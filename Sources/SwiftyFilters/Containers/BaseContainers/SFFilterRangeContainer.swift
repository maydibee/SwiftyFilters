//
//  SFFilterRangeContainer.swift
//  ObservationFilters
//
//  Created by Michael Skuratau on 11/02/25.
//

import Foundation


// MARK: - Range filter container (API-RO)

public class SFFilterRangeContainer<FilteredItem, CriteriaItem: Comparable>: SFFilterNullableContainer {
    
    public var range: SFFilterRange<CriteriaItem> = .init(lowerBound: nil, upperBound: nil)
    
    public var isNoneEnabled: Bool
    public var isNoneIncluded: Bool
    
    public var isFilterActive: Bool {
        let isBoundSelected = range.lowerBound != nil || range.upperBound != nil
        if isNoneIncluded {
            return isBoundSelected || !isNoneEnabled
        }
        return isBoundSelected
    }
    
    private let resolver: any SFFilterResolver<FilteredItem, SFFilterRange<CriteriaItem>>
    
    
    public init(resolver: any SFFilterResolver<FilteredItem, SFFilterRange<CriteriaItem>>,
                isNoneIncluded: Bool = false) {
        self.resolver = resolver
        self.isNoneIncluded = isNoneIncluded
        self.isNoneEnabled = isNoneIncluded
    }
    
    public func filterItems(inputItems: [FilteredItem]) -> [FilteredItem] {
        guard isFilterActive else { return inputItems }
        return self.resolver.filterItems(inputItems, basedOn: range, isNoneEnabled: isNoneEnabled)
    }
}
