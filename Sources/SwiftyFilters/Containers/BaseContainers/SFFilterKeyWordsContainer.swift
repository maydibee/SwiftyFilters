//
//  SFFilterKeyWordsContainer.swift
//  ObservationFilters
//
//  Created by Michael Skuratau on 13/02/25.
//

import Foundation


// MARK: - Keywords filter container (API-RO)

public class SFFilterKeyWordsContainer<FilteredItem, CriteriaItem: StringProtocol>: SFFilterNullableContainer {
    
    public var keywordsModel = SFFilterKeywordsModel<CriteriaItem>()
    
    public var isNoneEnabled: Bool
    public var isNoneIncluded: Bool
    
    public var isFilterActive: Bool {
        let isKeywordsEmpty = keywordsModel.isEmpty
        if isNoneIncluded {
            return !isKeywordsEmpty || !isNoneEnabled
        }
        return !isKeywordsEmpty
    }
    
    private let resolver: any SFFilterResolver<FilteredItem, SFFilterKeywordsModel<CriteriaItem>>
    
    
    public init(resolver: any SFFilterResolver<FilteredItem, SFFilterKeywordsModel<CriteriaItem>>,
                isNoneIncluded: Bool = false) {
        self.resolver = resolver
        self.isNoneIncluded = isNoneIncluded
        self.isNoneEnabled = isNoneIncluded
    }
    
    public func filterItems(inputItems: [FilteredItem]) -> [FilteredItem] {
        guard isFilterActive else { return inputItems }
        return self.resolver.filterItems(inputItems, basedOn: keywordsModel, isNoneEnabled: isNoneEnabled)
    }
}
