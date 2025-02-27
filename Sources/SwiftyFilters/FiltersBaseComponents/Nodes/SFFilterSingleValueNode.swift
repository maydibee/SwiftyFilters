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


// MARK: - Single value filter node (API-RO)
// TODO: add accessors
// TODO: - Add doc


public class SFFilterSingleValueNode<FilteredItem, CriteriaItem: Equatable>: SFFilterNode<FilteredItem> {
    
    private let singleValueViewProvider: any SFFilterSingleValueViewProvider<FilteredItem, CriteriaItem>
    
    lazy private var singleValueFilterComponent: SFFilterSingleValueComponent<FilteredItem, CriteriaItem>? = {
        component as? SFFilterSingleValueComponent<FilteredItem, CriteriaItem>
    }()
    
    @Published public var value: CriteriaItem? {
        didSet {
            singleValueFilterComponent?.updateValue(value)
            self.updateState()
            parent?.updateState()
        }
    }
    
    
    init(component: SFFilterComponent<FilteredItem>, viewProvider: any SFFilterSingleValueViewProvider<FilteredItem, CriteriaItem>) {
        self.singleValueViewProvider = viewProvider
        super.init(component: component)
    }

    public override func resetAllFilters() {
        value = nil
        nestedNodes.forEach { node in
            node.resetAllFilters()
        }
    }
}
