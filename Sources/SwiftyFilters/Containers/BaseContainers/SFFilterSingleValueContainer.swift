//
//  SFFilterSingleValueContainer.swift
//  ObservationFilters
//
//  Created by Michael Skuratau on 14/02/25.
//

import Foundation


// MARK: - Single value filter container (API-RO)

public class SFFilterSingleValueContainer<FilteredItem, CriteriaItem: Equatable>: SFFilterNullableContainer {
    
    public var value: CriteriaItem?
    
    public var isNoneEnabled: Bool
    public var isNoneIncluded: Bool
    
    public var isFilterActive: Bool {
        if isNoneIncluded {
            return value != nil || !isNoneEnabled
        }
        return value != nil
    }
    
    private let resolver: any SFFilterResolver<FilteredItem, CriteriaItem>
    
    
    public init(resolver: any SFFilterResolver<FilteredItem, CriteriaItem>,
                isNoneIncluded: Bool = false) {
        self.resolver = resolver
        self.isNoneIncluded = isNoneIncluded
        self.isNoneEnabled = isNoneIncluded
    }
    
    public func filterItems(inputItems: [FilteredItem]) -> [FilteredItem] {
        guard let value else { return inputItems }
        return self.resolver.filterItems(inputItems, basedOn: value, isNoneEnabled: isNoneEnabled)
    }
}
