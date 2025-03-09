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


/// A node in the filter tree that manages the state of the current filter component and its child nodes.
///
/// This class is responsible for maintaining the state of a filter component, including its selection status,
/// loading state, and nested child nodes.
///
/// ### Generic Parameters
/// - `FilteredItem`: The type of data being filtered.
///
public class SFFilterNode<FilteredItem>: Identifiable, ObservableObject {
    
    /// A unique identifier for the node.
    public let id = UUID()
    
    /// The title of the filter node, which matches the title of the associated filter component.
    public let title: String
    let isComposite: Bool
    
    weak var parent: SFFilterNode?
    
    let component: SFFilterComponent<FilteredItem>
    
    /// A flag indicating whether the node is currently loading data.
    @Published public var isLoading: Bool = false
    
    /// The child nodes of the current node.
    @Published public var nestedNodes: [SFFilterNode<FilteredItem>] = []
    
    /// A flag indicating whether the current node is selected.
    ///
    /// When set, it updates the state of the associated component and propagates the change to the parent node.
    ///
    @Published public var isItemEnabled: Bool {
        didSet {
            component.isItemEnabled = isItemEnabled
            parent?.updateState()
        }
    }
    
    
    init(component: SFFilterComponent<FilteredItem>) {
        self.component = component
        self.title = component.title
        self.isComposite = component.isComposite
        self.isItemEnabled = component.isItemEnabled
    }
    
    /// Resets the filter tree starting from the current node.
    ///
    /// All nested nodes are also reset.
    ///
    public func resetAllFilters() {
        isItemEnabled = true
        nestedNodes.forEach { node in
            node.resetAllFilters()
        }
    }
    
    /// Deselects all nodes in the filter tree starting from the current node.
    ///
    public func deselectAll() {
        isItemEnabled = false
        nestedNodes.forEach { node in
            node.deselectAll()
        }
    }

    /// Loads filter items or child nodes if they are not already loaded.
    ///
    /// Sets `isLoading` to `true` during the loading process.
    public func loadFilterIfNeeded() async {
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
    
    func getFilteredData(from items: [FilteredItem]) -> [FilteredItem] {
        var filteredArray = component.getFilteredItems(for: items)
        nestedNodes.forEach { nestedNode in
            filteredArray = nestedNode.getFilteredData(from: filteredArray)
        }
        return filteredArray
    }

    func updateState() {
        self.component.updateState()
        self.isItemEnabled = component.isItemEnabled
    }
    
    func makeView() -> any View {
        Text("No view provided")
    }
}
