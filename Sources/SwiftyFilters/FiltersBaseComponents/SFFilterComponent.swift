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


// MARK: - Filter component base class

/// A base class representing a filter component.
///
/// Instances of this class (or its subclasses) are created by the client code using the `SFFilterComponentsFactory`
/// and are used to build the filter tree.
///
public class SFFilterComponent<FilteredItem> {
    
    var title: String
    var isItemEnabled: Bool
    var isComposite: Bool
    var isAllActionIncluded: Bool
    
    
    init(title: String, isItemEnabled: Bool, isComposite: Bool, isAllActionIncluded: Bool = false) {
        self.title = title
        self.isItemEnabled = isItemEnabled
        self.isComposite = isComposite
        self.isAllActionIncluded = isAllActionIncluded
    }
    
    func loadNestedItems() async -> [SFFilterComponent<FilteredItem>] {
        fatalError("Must be overridden")
    }
    
    func updateState() {
        fatalError("Must be overridden")
    }
    
    func createRelatedNode() -> SFFilterNode<FilteredItem> {
        fatalError("Must be overridden")
    }
    
    func getFilteredItems(for items: [FilteredItem]) -> [FilteredItem] {
        return items
    }
    
    func makeView() -> any View {
        Text("View not defined")
    }
}
