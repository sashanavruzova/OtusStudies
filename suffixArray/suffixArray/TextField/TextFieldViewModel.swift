//
//  TextFieldViewModel.swift
//  suffixArray
//
//  Created by Александра Наврузова on 20/06/2023.
//

import Foundation

final class TextFieldViewModel: ObservableObject {
    @Published var suffixCountSorted = ""
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
    }
    
    func countSuffixesFrom(text: String) {
        let words = extractWords(from: text)
        
        let suffixCount = countSuffixes(in: words)
        
        suffixes = createSuffixInfo(from: suffixCount)
        
        sortSuffixes()
    }
    
    private func extractWords(from text: String) -> [String] {
        return text.split(separator: " ").map { String($0) }
    }
    
    private func countSuffixes(in words: [String]) -> [String: Int] {
        return words
            .flatMap { SuffixSequence(word: $0) }
            .filter { $0.count >= 3 }
            .reduce(into: [String: Int]()) { suffixCount, suffix in
                suffixCount[suffix, default: 0] += 1
            }
    }
    
    private func createSuffixInfo(from suffixCount: [String: Int]) -> [SuffixInfo] {
        return suffixCount.map { SuffixInfo(word: $0.key, count: $0.value) }
    }
    
    private func sortSuffixes() {
        switch sortMode {
        case .alphabetically:
            sortSuffixes(type: sortType)
        case .top10:
            fillTop10ThreeLettered()
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
        
        fillTop10ThreeLettered()
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
    
    private func fillTop10ThreeLettered() {
        let top10ThreeLetteredSuffixes = Array(suffixes
            .filter { $0.word.count == 3 }
            .sorted { info1, info2 in info1.count > info2.count }
            .prefix(10))
        combineSortedSuffixes(suffixes: top10ThreeLetteredSuffixes)
    }
    
    private func combineSortedSuffixes(suffixes: [SuffixInfo]) {
        let suffixCountSorted = suffixes.reduce(into: "") { res, info in
                    let countString = info.count > 1 ? " – \(info.count)" : ""
                    res += "\(info.word)\(countString)\n"
                }
                self.suffixCountSorted = suffixCountSorted
    }
}
