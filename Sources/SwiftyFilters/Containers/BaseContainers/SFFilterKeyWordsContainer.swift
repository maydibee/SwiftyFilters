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


// MARK: - Keywords filter container

class SFFilterKeyWordsContainer<FilteredItem, CriteriaItem: StringProtocol>: SFFilterNullableContainer {
    
    var keywordsModel = SFFilterKeywordsModel<CriteriaItem>()
    
    var isNoneEnabled: Bool
    var isNoneIncluded: Bool
    
    var isFilterActive: Bool {
        let isKeywordsEmpty = keywordsModel.isEmpty
        if isNoneIncluded {
            return !isKeywordsEmpty || !isNoneEnabled
        }
        return !isKeywordsEmpty
    }
    
    private let resolver: any SFFilterResolver<FilteredItem, SFFilterKeywordsModel<CriteriaItem>>
    
    
    init(resolver: any SFFilterResolver<FilteredItem, SFFilterKeywordsModel<CriteriaItem>>,
                isNoneIncluded: Bool = false) {
        self.resolver = resolver
        self.isNoneIncluded = isNoneIncluded
        self.isNoneEnabled = isNoneIncluded
    }
    
    func filterItems(inputItems: [FilteredItem]) -> [FilteredItem] {
        guard isFilterActive else { return inputItems }
        return self.resolver.filterItems(inputItems, basedOn: keywordsModel, isNoneEnabled: isNoneEnabled)
    }
}
