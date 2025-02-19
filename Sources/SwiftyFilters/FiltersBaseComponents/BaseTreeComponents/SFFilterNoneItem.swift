//
//  SFFilterNoneItem.swift
//  ObservationFilters
//
//  Created by Michael Skuratau on 16/02/25.
//

import Foundation


// MARK: - Selectable filter None sub-component (API-RO)

public class SFFilterNoneItem<FilteredItem>: SFFilterComponent {
    
    public let title: String
    public let isComposite: Bool = false
    public var isItemEnabled: Bool = true {
        didSet {
            self.relatedFilter.isNoneEnabled = isItemEnabled
        }
    }
    
    private let relatedFilter: SFFilterNullableContainer
    
    
    public init(title: String, relatedFilter: SFFilterNullableContainer) {
        self.title = title
        self.relatedFilter = relatedFilter
    }
    
    public func loadNestedItems() async -> [any SFFilterComponent<FilteredItem>] { [] }
    
    public func updateState() {}
    
    public func createRelatedNode() -> SFFilterNode<FilteredItem> {
        SFFilterNode<FilteredItem>(component: self)
    }
}
