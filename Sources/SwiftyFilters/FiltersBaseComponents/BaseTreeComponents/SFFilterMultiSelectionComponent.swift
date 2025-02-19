//
//  SFFilterMultiSelectionComponent.swift
//  ObservationFilters
//
//  Created by Michael Skuratau on 10/02/25.
//

import Foundation


// MARK: - Multi-select filter component (API-RO)

public class SFFilterMultiSelectionComponent<FilteredItem, CriteriaItem: Identifiable & SFFiltersTitleable>: SFFilterComponent {
    
    public let title: String
    public let isComposite: Bool = true
    public var isItemEnabled: Bool
    public let isAllActionIncluded: Bool = true
    
    private let filter: SFFilterMultiSelectionContainer<FilteredItem, CriteriaItem>
    private let noneItemTitle: String
    
    
    public init(title: String, noneItemTitle: String, filter: SFFilterMultiSelectionContainer<FilteredItem, CriteriaItem>) {
        self.title = title
        self.noneItemTitle = noneItemTitle
        self.isItemEnabled = !filter.isFilterActive
        self.filter = filter
    }
    
    public func loadNestedItems() async -> [any SFFilterComponent<FilteredItem>] {
        var nestedItems: [any SFFilterComponent<FilteredItem>] = []
        
        let fetchedItems = await self.filter.initializeFilter()
        
        if self.filter.isNoneIncluded {
            let noneItem = SFFilterNoneItem<FilteredItem>(title: noneItemTitle, relatedFilter: self.filter)
            nestedItems.append(noneItem)
        }
        
        fetchedItems.forEach { fetchedItem in
            let component = SFFilterItem(title: fetchedItem.title, item: fetchedItem, relatedFilter: self.filter)
            nestedItems.append(component)
        }
        
        return nestedItems
    }
    
    public func updateState() {
        self.isItemEnabled = !filter.isFilterActive
    }
    
    public func createRelatedNode() -> SFFilterNode<FilteredItem> {
        SFFilterNode<FilteredItem>(component: self)
    }
}


// MARK: - SFFilterFilterable implementation

extension SFFilterMultiSelectionComponent: SFFilterFilterable {
    
    public func getFilteredItems(for items: [FilteredItem]) -> [FilteredItem] {
        return filter.filterItems(inputItems: items)
    }
}


