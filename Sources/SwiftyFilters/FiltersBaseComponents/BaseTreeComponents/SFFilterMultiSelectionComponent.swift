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


// MARK: - Multi-select filter component (API-RO)

public class SFFilterMultiSelectionComponent<FilteredItem, CriteriaItem: Identifiable & SFFiltersTitleable>: SFFilterComponent<FilteredItem> {
    
    private let filter: SFFilterMultiSelectionContainer<FilteredItem, CriteriaItem>
    private let noneItemTitle: String
    
    public var multiSelectionViewProvider: any SFFilterMultiSelectionViewProvider<FilteredItem>
    
    
    public init(title: String,
                noneItemTitle: String,
                filter: SFFilterMultiSelectionContainer<FilteredItem, CriteriaItem>,
                viewProvider: any SFFilterMultiSelectionViewProvider<FilteredItem>
                
    ) {
        self.noneItemTitle = noneItemTitle
        self.filter = filter
        self.multiSelectionViewProvider = viewProvider
        super.init(title: title,
                   isItemEnabled: !filter.isFilterActive,
                   isComposite: true,
                   isAllActionIncluded: true)
    }
    
    public override func loadNestedItems() async -> [SFFilterComponent<FilteredItem>] {
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
    
    public override func updateState() {
        self.isItemEnabled = !filter.isFilterActive
    }
    
    public override func createRelatedNode() -> SFFilterNode<FilteredItem> {
        SFFilterNode<FilteredItem>(component: self)
    }
    
    public override func getFilteredItems(for items: [FilteredItem]) -> [FilteredItem] {
        return filter.filterItems(inputItems: items)
    }
}
