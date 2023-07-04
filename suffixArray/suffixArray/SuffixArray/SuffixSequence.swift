//
//  SuffixSequence.swift
//  suffixArray
//
//  Created by Александра Наврузова on 29/06/2023.
//

import Foundation

struct SuffixSequence: Sequence {
    private let word: String
   
    init(word: String) {
        self.word = word
    }

    func makeIterator() -> SuffixIterator {
        SuffixIterator(word: word)
    }
}
