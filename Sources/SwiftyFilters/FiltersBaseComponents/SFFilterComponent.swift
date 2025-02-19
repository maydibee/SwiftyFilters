//
//  SFFilterComponent.swift
//  ObservationFilters
//
//  Created by Michael Skuratau on 10/02/25.
//

import Foundation


// MARK: - Filter component abstraction (API-RO)

public protocol SFFilterComponent<FilteredItem>: AnyObject {

    associatedtype FilteredItem
    
    var title: String { get }
    var isItemEnabled: Bool { get set }
    var isComposite: Bool { get }
    var isAllActionIncluded: Bool { get }
    
    func loadNestedItems() async -> [any SFFilterComponent<FilteredItem>]
    func updateState()
    
    func createRelatedNode() -> SFFilterNode<FilteredItem>
}

public extension SFFilterComponent {
    var isAllActionIncluded: Bool { false }
}
