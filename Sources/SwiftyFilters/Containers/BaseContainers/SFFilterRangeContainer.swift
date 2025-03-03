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


// MARK: - Range filter container

class SFFilterRangeContainer<FilteredItem, CriteriaItem: Comparable>: SFFilterNullableContainer {
    
    var range: SFFilterRange<CriteriaItem> = .init(lowerBound: nil, upperBound: nil)
    
    var isNoneEnabled: Bool
    var isNoneIncluded: Bool
    
    var isFilterActive: Bool {
        let isBoundSelected = range.lowerBound != nil || range.upperBound != nil
        if isNoneIncluded {
            return isBoundSelected || !isNoneEnabled
        }
        return isBoundSelected
    }
    
    private var filterBehavior: (([FilteredItem], SFFilterRange<CriteriaItem>, _ isNoneEnabled: Bool) -> [FilteredItem])
    
    
    init(filterBehavior: @escaping (([FilteredItem], SFFilterRange<CriteriaItem>, _ isNoneEnabled: Bool) -> [FilteredItem]), isNoneIncluded: Bool = false) {
        self.filterBehavior = filterBehavior
        self.isNoneIncluded = isNoneIncluded
        self.isNoneEnabled = isNoneIncluded
    }
    
    
    convenience init(resolver: any SFFilterResolver<FilteredItem, SFFilterRange<CriteriaItem>>,
                isNoneIncluded: Bool = false) {
        
        let filterBehavior = { inputItems, criteriaItem, isNoneEnabled in
            resolver.filterItems(inputItems, basedOn: criteriaItem, isNoneEnabled: isNoneEnabled)
        }
        
        self.init(
            filterBehavior: filterBehavior,
            isNoneIncluded: isNoneIncluded
        )
    }
    
    func filterItems(inputItems: [FilteredItem]) -> [FilteredItem] {
        guard isFilterActive else { return inputItems }
        return self.filterBehavior(inputItems, range, isNoneEnabled)
    }
}
