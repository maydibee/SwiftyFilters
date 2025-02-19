//
//  FilterContainer.swift
//  ObservationFilters
//
//  Created by Michael Skuratau on 07/02/25.
//

import Foundation


// MARK: - Multi-select filter container (API-RO)

public class SFFilterMultiSelectionContainer<FilteredItem, CriteriaItem: Identifiable & SFFiltersTitleable>: SFFilterNullableContainer {
    
    public var allItems = Array<CriteriaItem>()
    public var selectedItems = Array<CriteriaItem>()
    
    public var isNoneEnabled: Bool
    public let isNoneIncluded: Bool
    
    public var isFilterActive: Bool {
        let isAllSelected: Bool = allItems.count == selectedItems.count
        if isNoneIncluded {
            return !isAllSelected || !isNoneEnabled
        }
        return !isAllSelected
    }
    
    private let resolver: any SFFilterResolver<FilteredItem, [CriteriaItem]>
    private let fetcher: any SFFilterFetcher<CriteriaItem>
    
    
    public init(resolver: any SFFilterResolver<FilteredItem, [CriteriaItem]>,
                fetcher: any SFFilterFetcher<CriteriaItem>,
                isNoneIncluded: Bool = false) {
        self.resolver = resolver
        self.fetcher = fetcher
        self.isNoneIncluded = isNoneIncluded
        self.isNoneEnabled = isNoneIncluded
    }
    
    @discardableResult
    public func initializeFilter() async -> [CriteriaItem] {
        let fetchedItems = await self.fetcher.fetchFilterItems()
        self.allItems = fetchedItems
        self.selectedItems = fetchedItems
        return fetchedItems
    }
    
    public func filterItems(inputItems: [FilteredItem]) -> [FilteredItem] {
        guard isFilterActive else { return inputItems }
        return self.resolver.filterItems(inputItems, basedOn: self.selectedItems, isNoneEnabled: isNoneEnabled)
    }
    
    public func isItemSelected(_ item: CriteriaItem) -> Bool {
        self.selectedItems.contains { $0.id == item.id }
    }
}
