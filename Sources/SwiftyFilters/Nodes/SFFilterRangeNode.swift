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


/// A specialized node manager for range-based filters.
///
/// This node can be used as a view model for custom UI components. It manages the state of a range filter
/// and provides a `range` model for UI updates.
///
/// ### Generic Parameters
/// - `FilteredItem`: The type of data being filtered.
/// - `CriteriaItem`: The type of criteria for filtering, confirmes to `Comparable`.
///
public class SFFilterRangeNode<FilteredItem, CriteriaItem: Comparable>: SFFilterNode<FilteredItem> {
    
    private let view: ((SFFilterRangeNode<FilteredItem, CriteriaItem>) -> any View)
    
    lazy private var rangeFilterComponent: SFFilterRangeComponent<FilteredItem, CriteriaItem>? = {
        component as? SFFilterRangeComponent<FilteredItem, CriteriaItem>
    }()

    /// A model representing the range for UI updates.
    ///
    /// When set, it updates the associated filter component and propagates the change to the parent node.
    /// 
    @Published public var range: SFFilterRange<CriteriaItem> = .init(lowerBound: nil, upperBound: nil) {
        didSet {
            rangeFilterComponent?.updateRange(range)
            self.updateState()
            parent?.updateState()
        }
    }
    

    init(component: SFFilterComponent<FilteredItem>, view: @escaping ((SFFilterRangeNode<FilteredItem, CriteriaItem>) -> any View)) {
        self.view = view
        super.init(component: component)
    }
    
    /// Resets the range model and all nested nodes.
    override public func resetAllFilters() {
        range = .init(lowerBound: nil, upperBound: nil)
        nestedNodes.forEach { node in
            node.resetAllFilters()
        }
    }
    
    override func makeView() -> any View {
        view(self)
    }
}
