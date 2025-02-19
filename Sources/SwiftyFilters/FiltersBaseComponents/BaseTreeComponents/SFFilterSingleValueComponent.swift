//
//  SFFilterSingleValueComponent.swift
//  ObservationFilters
//
//  Created by Michael Skuratau on 14/02/25.
//

import Foundation


// MARK: - Single value filter component (API-RO)

public class SFFilterSingleValueComponent<FilteredItem, CriteriaItem: Equatable>: SFFilterComponent {
    
    public let title: String
    public let isComposite: Bool = false
    public var isItemEnabled: Bool
    
    private let filter: SFFilterSingleValueContainer<FilteredItem, CriteriaItem>
    private let noneItemTitle: String
    
    
    public init(title: String, noneItemTitle: String, filter: SFFilterSingleValueContainer<FilteredItem, CriteriaItem>) {
        self.title = title
        self.noneItemTitle = noneItemTitle
        self.isItemEnabled = !filter.isFilterActive
        self.filter = filter
    }
    
    public func loadNestedItems() async -> [any SFFilterComponent<FilteredItem>] {
        var nestedItems: [any SFFilterComponent<FilteredItem>] = []
        
        if self.filter.isNoneIncluded {
            let noneItem = SFFilterNoneItem<FilteredItem>(title: noneItemTitle, relatedFilter: self.filter)
            nestedItems.append(noneItem)
        }
        
        return nestedItems
    }
    
    public func updateState() {
        self.isItemEnabled = !filter.isFilterActive
    }
    
    public func updateValue(_ value: CriteriaItem?) {
        filter.value = value
    }
    
    public func createRelatedNode() -> SFFilterNode<FilteredItem> {
        SFFilterSingleValueNode<FilteredItem, CriteriaItem>(component: self)
    }
}


// MARK: - SFFilterFilterable implementation

extension SFFilterSingleValueComponent: SFFilterFilterable {
    
    public func getFilteredItems(for items: [FilteredItem]) -> [FilteredItem] {
        return filter.filterItems(inputItems: items)
    }
}
