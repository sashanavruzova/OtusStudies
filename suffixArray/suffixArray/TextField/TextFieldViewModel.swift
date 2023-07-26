//
//  TextFieldViewModel.swift
//  suffixArray
//
//  Created by Aleksandra Navruzova on 20/06/2023.
//

import Foundation

final class TextFieldViewModel: ObservableObject {
    @Published var suffixCountSorted = ""
    @Published var searchHistory: [String] = .init()
    
    private let jobQueue = JobQueue(concurrency: 5)
    private var sortMode: SortMode = .alphabetically
    private var sortType: SortType = .asc
    private var suffixes = [SuffixInfo]()
    
    enum SortMode {
        case alphabetically
        case top10
    }
    
    enum SortType {
        case asc
        case desc
    }
    
    struct SuffixInfo {
        let word: String
        let count: Int
        let time: UInt64
    }
    
    @MainActor
    func countSuffixesFrom(text: String) async {
        let words = extractWords(from: text)

        let startTime = DispatchTime.now().uptimeNanoseconds

        suffixes = try! await withThrowingTaskGroup(of: [String: Int].self, returning: [SuffixInfo].self) { taskGroup in
            for word in words {
                taskGroup.addTask {
                    let result = try! await self.jobQueue.submit(operation: { TextFieldViewModel.countSuffixes(word) })
                    return result
                }
            }
            
            var result = [String: Int]()
            for try await task in taskGroup {
                result.merge(task) { $0 + $1 }
            }
            let endTime = DispatchTime.now().uptimeNanoseconds

            return result.map { SuffixInfo(word: $0.key, count: $0.value, time: (endTime - startTime)) }
        }
        
        sortSuffixes()
    }
    
    func fillHistoryList(text: String) {
        searchHistory.append(text)
    }
    
    private func extractWords(from text: String) -> [String] {
        return text.split(separator: " ").map { String($0) }
    }
    
    static func countSuffixes(_ text: String) -> [String: Int] {
        let words = text.split(separator: " ").map { String($0) }
                let suffixCount = Dictionary(words
                    .flatMap { SuffixSequence(word: $0) }
                    .filter { $0.count >= 3 }
                    .map { ($0, 1) }, uniquingKeysWith: +)

                return suffixCount
    }
    
    private func sortSuffixes() {
        switch sortMode {
        case .alphabetically:
            sortSuffixes(type: sortType)
        case .top10:
            sortTop10ThreeLettered()
        }
    }
    
    func setAlphabeticalSort(type: SortType) {
        sortMode = .alphabetically
        sortType = type
        
        sortSuffixes(type: type)
    }
    
    func setTop10Sort() {
        sortMode = .top10
        sortType = .desc
        
        sortTop10ThreeLettered()
    }
    
    private func sortSuffixes(type: SortType) {
        let sortedSuffixes = suffixes.sorted { compare(info1: $0.word, info2: $1.word, sortType: type) }
        combineSortedSuffixes(suffixes: sortedSuffixes)
    }
    
    private func compare<T: Comparable>(info1: T, info2: T, sortType: SortType) -> Bool {
        switch sortType {
        case .asc:
            return info1 < info2
        case .desc:
            return info1 > info2
        }
    }
    
    private func sortTop10ThreeLettered() {
        let top10ThreeLetteredSuffixes = Array(suffixes
            .filter { $0.word.count == 3 }
            .sorted { info1, info2 in info1.count > info2.count }
            .prefix(10))
        combineSortedSuffixes(suffixes: top10ThreeLetteredSuffixes)
    }
    
    private func combineSortedSuffixes(suffixes: [SuffixInfo]) {
        suffixCountSorted = suffixes.reduce("", { res, info in
            info.count > 1 ? res + "\(info.word) – \(info.count) / \(info.time) ns\n" : res + "\(info.word) / \(info.time) ns\n"
        })
    }
}
