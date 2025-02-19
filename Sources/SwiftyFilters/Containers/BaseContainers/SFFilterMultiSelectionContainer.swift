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


// MARK: - Multi-select filter container (API-RO)

public class SFFilterMultiSelectionContainer<FilteredItem, CriteriaItem: Identifiable & SFFiltersTitleable>: SFFilterNullableContainer {
    
    public var allItems = Array<CriteriaItem>()
    public var selectedItems = Array<CriteriaItem>()
    
    public var isNoneEnabled: Bool
    public let isNoneIncluded: Bool
    
    public var isFilterActive: Bool {
        let isAllSelected: Bool = allItems.count == selectedItems.count
        if isNoneIncluded {
            return !isAllSelected || !isNoneEnabled
        }
        return !isAllSelected
    }
    
    private let resolver: any SFFilterResolver<FilteredItem, [CriteriaItem]>
    private let fetcher: any SFFilterFetcher<CriteriaItem>
    
    
    public init(resolver: any SFFilterResolver<FilteredItem, [CriteriaItem]>,
                fetcher: any SFFilterFetcher<CriteriaItem>,
                isNoneIncluded: Bool = false) {
        self.resolver = resolver
        self.fetcher = fetcher
        self.isNoneIncluded = isNoneIncluded
        self.isNoneEnabled = isNoneIncluded
    }
    
    @discardableResult
    public func initializeFilter() async -> [CriteriaItem] {
        let fetchedItems = await self.fetcher.fetchFilterItems()
        self.allItems = fetchedItems
        self.selectedItems = fetchedItems
        return fetchedItems
    }
    
    public func filterItems(inputItems: [FilteredItem]) -> [FilteredItem] {
        guard isFilterActive else { return inputItems }
        return self.resolver.filterItems(inputItems, basedOn: self.selectedItems, isNoneEnabled: isNoneEnabled)
    }
    
    public func isItemSelected(_ item: CriteriaItem) -> Bool {
        self.selectedItems.contains { $0.id == item.id }
    }
}
