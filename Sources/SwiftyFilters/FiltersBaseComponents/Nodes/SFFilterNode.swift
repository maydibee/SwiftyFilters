//
//  SFFilterNode.swift
//  ObservationFilters
//
//  Created by Michael Skuratau on 10/02/25.
//

import Foundation


// MARK: Filter node (API-RW)

open class SFFilterNode<FilteredItem>: Identifiable, ObservableObject {
    
    public let id = UUID()
    let title: String
    let isComposite: Bool
    
    weak var parent: SFFilterNode?
    
    let component: any SFFilterComponent<FilteredItem>
    
    @Published public var isLoading: Bool = false
    @Published public var nestedNodes: [SFFilterNode<FilteredItem>] = []
    @Published public var isItemEnabled: Bool {
        didSet {
            component.isItemEnabled = isItemEnabled
            parent?.updateState()
        }
    }
    
    
    init(component: any SFFilterComponent<FilteredItem>) {
        self.component = component
        self.title = component.title
        self.isComposite = component.isComposite
        self.isItemEnabled = component.isItemEnabled
    }
    
    open func resetAllFilters() {
        isItemEnabled = true
        nestedNodes.forEach { node in
            node.resetAllFilters()
        }
    }
    
    open func deselectAll() {
        isItemEnabled = false
        nestedNodes.forEach { node in
            node.deselectAll()
        }
    }
    
    open func getFilteredData(from items: [FilteredItem]) -> [FilteredItem] {
        let filterableComponent = component as? (any SFFilterFilterable<FilteredItem>)
        
        var filteredArray = filterableComponent?.getFilteredItems(for: items) ?? items
        nestedNodes.forEach { nestedNode in
            filteredArray = nestedNode.getFilteredData(from: filteredArray)
        }
        return filteredArray
    }
    
    open func loadFilterIfNeeded() async {
        guard nestedNodes.isEmpty else { return }

        await MainActor.run { isLoading = true }

        let loadedItems = await component.loadNestedItems()
        
        await MainActor.run {
            self.nestedNodes = loadedItems.map {
                let node: SFFilterNode<FilteredItem> = $0.createRelatedNode()
                node.parent = self
                return node
            }
            isLoading = false
        }
    }

    open func updateState() {
        self.component.updateState()
        self.isItemEnabled = component.isItemEnabled
    }
}
