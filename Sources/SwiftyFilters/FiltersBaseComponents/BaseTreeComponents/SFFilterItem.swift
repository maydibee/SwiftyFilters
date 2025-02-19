//
//  SFFilterItem.swift
//  ObservationFilters
//
//  Created by Michael Skuratau on 10/02/25.
//

import Foundation


// MARK: - Selectable filter sub-component (API-RO)

public class SFFilterItem<FilteredItem, CriteriaItem: Identifiable & SFFiltersTitleable>: SFFilterComponent {
    
    public let title: String
    public let isComposite: Bool = false
    public var isItemEnabled: Bool = true {
        didSet {
            if isItemEnabled {
                if !self.relatedFilter.selectedItems.contains(where: {$0.id == item.id }) {
                    self.relatedFilter.selectedItems.append(item)
                }
            } else {
                self.relatedFilter.selectedItems.removeAll { $0.id == item.id }
            }
        }
    }
    
    private let item: CriteriaItem
    private let relatedFilter: SFFilterMultiSelectionContainer<FilteredItem, CriteriaItem>
    
    
    init(title: String, item: CriteriaItem, relatedFilter: SFFilterMultiSelectionContainer<FilteredItem, CriteriaItem>) {
        self.title = title
        self.item = item
        self.relatedFilter = relatedFilter
        self.isItemEnabled = relatedFilter.isItemSelected(self.item)
    }
    
    public func loadNestedItems() async -> [any SFFilterComponent<FilteredItem>] { [] }
    
    public func updateState() {}
    
    public func createRelatedNode() -> SFFilterNode<FilteredItem> {
        SFFilterNode<FilteredItem>(component: self)
    }
}
