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


// MARK: - Range filter node (API-RO)

public class SFFilterRangeNode<FilteredItem, CriteriaItem: Comparable>: SFFilterNode<FilteredItem> {
    
    public var rangeViewProvider: any SFFilterRangeViewProvider<FilteredItem, CriteriaItem>
    
    lazy private var rangeFilterComponent: SFFilterRangeComponent<FilteredItem, CriteriaItem>? = {
        component as? SFFilterRangeComponent<FilteredItem, CriteriaItem>
    }()

    @Published public var range: SFFilterRange<CriteriaItem> = .init(lowerBound: nil, upperBound: nil) {
        didSet {
            rangeFilterComponent?.updateRange(range)
            self.updateState()
            parent?.updateState()
        }
    }
    

    init(component: SFFilterComponent<FilteredItem>, viewProvider: any SFFilterRangeViewProvider<FilteredItem, CriteriaItem>) {
        self.rangeViewProvider = viewProvider
        super.init(component: component)
    }
    
    override public func resetAllFilters() {
        range = .init(lowerBound: nil, upperBound: nil)
        nestedNodes.forEach { node in
            node.resetAllFilters()
        }
    }
    
    override public func makeView() -> any View {
        rangeViewProvider.makeView(with: self)
    }
}
