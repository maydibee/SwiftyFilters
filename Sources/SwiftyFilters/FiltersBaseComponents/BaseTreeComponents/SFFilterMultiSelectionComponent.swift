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


// MARK: - Multi-select filter component

class SFFilterMultiSelectionComponent<FilteredItem, CriteriaItem: Identifiable & SFFiltersTitleable>: SFFilterComponent<FilteredItem> {
    
    private let filter: SFFilterMultiSelectionContainer<FilteredItem, CriteriaItem>
    private let view: ((SFFilterMultiSelectionNode<FilteredItem>) -> any View)
    private let noneItemTitle: String
    

    init(title: String,
         noneItemTitle: String,
         filter: SFFilterMultiSelectionContainer<FilteredItem, CriteriaItem>,
         view: @escaping ((SFFilterMultiSelectionNode<FilteredItem>) -> any View)
         
    ) {
        self.noneItemTitle = noneItemTitle
        self.filter = filter
        self.view = view
        super.init(title: title,
                   isItemEnabled: !filter.isFilterActive,
                   isComposite: false,
                   isAllActionIncluded: true)
    }
    
    convenience init(title: String,
         noneItemTitle: String,
         filter: SFFilterMultiSelectionContainer<FilteredItem, CriteriaItem>,
         viewProvider: any SFFilterMultiSelectionViewProvider<FilteredItem>
         
    ) {
    
        let view = { node in
            viewProvider.makeView(with: node)
        }
        
        self.init(title: title,
                   noneItemTitle: noneItemTitle,
                   filter: filter,
                   view: view
        )
    }
    
    override func loadNestedItems() async -> [SFFilterComponent<FilteredItem>] {
        var nestedItems: [SFFilterComponent<FilteredItem>] = []
        
        let fetchedItems = await self.filter.initializeFilter()
        
        if self.filter.isNoneIncluded {
            let noneItem = SFFilterNoneItem<FilteredItem>(title: noneItemTitle, relatedFilter: self.filter)
            nestedItems.append(noneItem)
        }
        
        fetchedItems.forEach { fetchedItem in
            let component = SFFilterItem(title: fetchedItem.title, item: fetchedItem, relatedFilter: self.filter)
            nestedItems.append(component)
        }
        
        return nestedItems
    }
    
    override func updateState() {
        self.isItemEnabled = !filter.isFilterActive
    }
    
    override func createRelatedNode() -> SFFilterNode<FilteredItem> {
        SFFilterMultiSelectionNode<FilteredItem>(component: self, view: self.view)
    }
    
    override func getFilteredItems(for items: [FilteredItem]) -> [FilteredItem] {
        return filter.filterItems(inputItems: items)
    }
}
