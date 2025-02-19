//
//  SFFilterMasterComponent.swift
//  ObservationFilters
//
//  Created by Michael Skuratau on 10/02/25.
//

import Foundation


// MARK: - Master filter component (API-RO)

public class SFFilterMasterComponent<FilteredItem>: SFFilterComponent {

    public let title: String
    public let isComposite: Bool = true
    public var isItemEnabled: Bool
    
    private var nestedFilterComponents: [any SFFilterComponent<FilteredItem>] = []
    
    
    public init(title: String, nestedFilterItems: [any SFFilterComponent<FilteredItem>]) {
        self.title = title
        self.nestedFilterComponents = nestedFilterItems
        self.isItemEnabled = !nestedFilterComponents.contains(where: { !$0.isItemEnabled })
    }
    
    public func loadNestedItems() async -> [any SFFilterComponent<FilteredItem>] {
        return self.nestedFilterComponents
    }
    
    public func updateState() {
        self.isItemEnabled = !nestedFilterComponents.contains(where: { !$0.isItemEnabled })
    }
    
    public func createRelatedNode() -> SFFilterNode<FilteredItem> {
        SFFilterNode<FilteredItem>(component: self)
    }
}
