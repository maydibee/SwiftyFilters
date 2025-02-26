//
// SwiftyFilters
//
// Copyright (c) 2025 Michael Skuratau - https://github.com/maydibee
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.


import Foundation
import SwiftUI


// MARK: Filter node (API-RW)

open class SFFilterNode<FilteredItem>: Identifiable, ObservableObject {
    
    public let id = UUID()
    let title: String
    let isComposite: Bool
    
    weak var parent: SFFilterNode?
    
    let component: SFFilterComponent<FilteredItem>
    var viewProvider: (any SFFilterViewProvider<FilteredItem>)?
    
    @Published public var isLoading: Bool = false
    @Published public var nestedNodes: [SFFilterNode<FilteredItem>] = []
    @Published public var isItemEnabled: Bool {
        didSet {
            component.isItemEnabled = isItemEnabled
            parent?.updateState()
        }
    }
    
    
    public init(component: SFFilterComponent<FilteredItem>) {
        self.component = component
        self.title = component.title
        self.isComposite = component.isComposite
        self.isItemEnabled = component.isItemEnabled
        //self.viewProvider = component.viewProvider
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
        var filteredArray = component.getFilteredItems(for: items)
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
    
    public func makeView() -> any View {
        Text("No view")
        //rangeViewProvider!.makeView(with: self)
    }
}


public class SFFilterMultiSelectionNode<FilteredItem>: SFFilterNode<FilteredItem> {
    
    public var multiSelectionViewProvider: any SFFilterMultiSelectionViewProvider<FilteredItem>
    
//    lazy private var multiSelectionFilterComponent: SFFilterMultiSelectionComponent<FilteredItem, CriteriaItem>? = {
//        component as? SFFilterMultiSelectionComponent<FilteredItem, CriteriaItem>
//    }()
    
    
    init(component: SFFilterComponent<FilteredItem>, viewProvider: any SFFilterMultiSelectionViewProvider<FilteredItem>) {
        self.multiSelectionViewProvider = viewProvider
        super.init(component: component)
    }
    
    override public func makeView() -> any View {
        multiSelectionViewProvider.makeView(with: self)
    }
}
