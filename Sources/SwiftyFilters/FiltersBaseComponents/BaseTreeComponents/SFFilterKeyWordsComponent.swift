//
//  SFFilterKeyWordsComponent.swift
//  ObservationFilters
//
//  Created by Michael Skuratau on 13/02/25.
//

import Foundation


// MARK: - Keywords filter component (API-RO)

public class SFFilterKeyWordsComponent<FilteredItem, CriteriaItem: StringProtocol>: SFFilterComponent {
    
    public let title: String
    public let isComposite: Bool = false
    public var isItemEnabled: Bool
    
    private let filter: SFFilterKeyWordsContainer<FilteredItem, CriteriaItem>
    private let noneItemTitle: String
    
    
    public init(title: String, noneItemTitle: String, filter: SFFilterKeyWordsContainer<FilteredItem, CriteriaItem>) {
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
    
    public func updateKeywords(_ keywords: SFFilterKeywordsModel<CriteriaItem>) {
        filter.keywordsModel = keywords
    }
    
    public func createRelatedNode() -> SFFilterNode<FilteredItem> {
        SFFilterKeywordsNode<FilteredItem, CriteriaItem>(component: self)
    }
}


// MARK: - SFFilterFilterable implementation

extension SFFilterKeyWordsComponent: SFFilterFilterable {
    
    public func getFilteredItems(for items: [FilteredItem]) -> [FilteredItem] {
        return filter.filterItems(inputItems: items)
    }
}
