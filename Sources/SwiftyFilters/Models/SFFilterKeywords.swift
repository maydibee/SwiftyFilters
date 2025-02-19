//
//  SFFilterKeywords.swift
//  ObservationFilters
//
//  Created by Michael Skuratau on 13/02/25.
//

import Foundation


struct SFFilterKeywords<T: StringProtocol> {
    
    var words: [T] = []
    
    func isSafisfy(_ value: T, isCaseSensitive: Bool = false) -> Bool {
        guard !words.isEmpty else { return true }
        if isCaseSensitive {
            return words.allSatisfy { value.contains($0) }
        } else {
            return words.allSatisfy { value.lowercased().contains($0.lowercased()) }
        }
    }
}
