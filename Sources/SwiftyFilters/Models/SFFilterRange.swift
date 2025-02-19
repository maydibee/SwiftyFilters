//
//  SFFilterRange.swift
//  ObservationFilters
//
//  Created by Michael Skuratau on 11/02/25.
//

import Foundation


public struct SFFilterRange<T: Comparable> {
    
    let lowerBound: T?
    let upperBound: T?
    
    public func contains(_ value: T) -> Bool {
        if let lowerBound = lowerBound, value < lowerBound {
            return false
        }
        if let upperBound = upperBound, value > upperBound {
            return false
        }
        return true
    }
}
