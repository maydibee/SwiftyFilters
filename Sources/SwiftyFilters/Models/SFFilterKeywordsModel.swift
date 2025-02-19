//
//  SFFilterKeywordsModel.swift
//  ObservationFilters
//
//  Created by Michael Skuratau on 13/02/25.
//

import Foundation


public struct SFFilterKeywordsModel<T: StringProtocol> {
    
    var keywordsContainer: SFFilterKeywords<T> = .init()
    var isCaseSensitive: Bool = false
    
    var isEmpty: Bool {
        keywordsContainer.words.isEmpty
    }
    
    var words: [T] {
        keywordsContainer.words
    }

    public func isSafisfy(_ value: T) -> Bool {
        keywordsContainer.isSafisfy(value, isCaseSensitive: self.isCaseSensitive)
    }
    
    mutating func addKeyword(_ keyword: T) {
        keywordsContainer.words.append(keyword)
    }
    
    mutating func removeKeyword(at index: Int) {
        keywordsContainer.words.remove(at: index)
    }
    
    mutating func reset() {
        keywordsContainer.words.removeAll()
        isCaseSensitive = false
    }
}
