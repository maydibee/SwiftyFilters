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


// MARK: - Selectable filter sub-component

class SFFilterItem<FilteredItem, CriteriaItem: Identifiable & SFFiltersTitleable>: SFFilterComponent<FilteredItem> {
    
    override var isItemEnabled: Bool {
        didSet {
            if isItemEnabled {
                if !self.relatedFilter.selectedItems.contains(where: {$0.id == item.id }) {
                    self.relatedFilter.selectedItems.append(item)
                }
            } else {
                self.relatedFilter.selectedItems.removeAll { $0.id == item.id }
            }
        }
    }
    
    private let item: CriteriaItem
    private let relatedFilter: SFFilterMultiSelectionContainer<FilteredItem, CriteriaItem>
    
    
    init(title: String, item: CriteriaItem, relatedFilter: SFFilterMultiSelectionContainer<FilteredItem, CriteriaItem>) {
        self.item = item
        self.relatedFilter = relatedFilter
        super.init(title: title, isItemEnabled: relatedFilter.isItemSelected(self.item), isComposite: false)
    }
    
    override func loadNestedItems() async -> [SFFilterComponent<FilteredItem>] { [] }
    
    override func updateState() {}
    
    override func createRelatedNode() -> SFFilterNode<FilteredItem> {
        SFFilterNode<FilteredItem>(component: self)
    }
}
