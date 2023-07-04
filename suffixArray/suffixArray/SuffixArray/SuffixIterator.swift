//
//  SuffixIterator.swift
//  suffixArray
//
//  Created by Александра Наврузова on 29/06/2023.
//

import Foundation

struct SuffixIterator: IteratorProtocol {
    private let word: String
    private let suffixes: [String.Index]
    private var currentIndex = 0

    init(word: String) {
        self.word = word
        self.suffixes = Array(word.indices).sorted { l, r in
            String(word.suffix(from: l)) < String(word.suffix(from: r))
        }
    }

    mutating func next() -> String? {
        guard currentIndex < suffixes.count else { return nil }
        let nextIndex = suffixes[currentIndex]
        currentIndex += 1
        return String(word.suffix(from: nextIndex))
    }
}
