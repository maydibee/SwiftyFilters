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


// MARK: - Filter's base components abstract factory

public class SFFilterComponentsFactory {
    
    public static func createMultiSelectionComponent<FilteredItem, CriteriaItem: Identifiable & SFFiltersTitleable>(title: String,
                                                                                                                    resolver: any SFFilterResolver<FilteredItem, [CriteriaItem]>,
                                                                                                                    fetcher: any SFFilterFetcher<CriteriaItem>,
                                                                                                                    isNoneIncluded: Bool = false,
                                                                                                                    noneItemTitle: String) -> SFFilterComponent<FilteredItem> {
        let container = SFFilterMultiSelectionContainer(resolver: resolver, fetcher: fetcher, isNoneIncluded: isNoneIncluded)
        let component = SFFilterMultiSelectionComponent(title: title, noneItemTitle: noneItemTitle, filter: container)
        return component
    }
    
    public static func createRangeComponent<FilteredItem, CriteriaItem: Comparable>(title: String,
                                                                                    resolver: any SFFilterResolver<FilteredItem, SFFilterRange<CriteriaItem>>,
                                                                                    isNoneIncluded: Bool = false,
                                                                                    noneItemTitle: String) -> SFFilterComponent<FilteredItem> {
        let container = SFFilterRangeContainer(resolver: resolver, isNoneIncluded: isNoneIncluded)
        let component = SFFilterRangeComponent(title: title, noneItemTitle: noneItemTitle, filter: container)
        return component
    }
    
    public static func createKeywordsComponent<FilteredItem, CriteriaItem: StringProtocol>(title: String,
                                                                                           resolver: any SFFilterResolver<FilteredItem, SFFilterKeywordsModel<CriteriaItem>>,
                                                                                           isNoneIncluded: Bool = false,
                                                                                           noneItemTitle: String) -> SFFilterComponent<FilteredItem> {
        let container = SFFilterKeyWordsContainer(resolver: resolver, isNoneIncluded: isNoneIncluded)
        let component = SFFilterKeyWordsComponent(title: title, noneItemTitle: noneItemTitle, filter: container)
        return component
    }
    
    public static func createSingleValueComponent<FilteredItem, CriteriaItem: Equatable>(title: String,
                                                                                         resolver: any SFFilterResolver<FilteredItem, CriteriaItem>,
                                                                                         isNoneIncluded: Bool = false,
                                                                                         noneItemTitle: String) -> SFFilterComponent<FilteredItem> {
        let container = SFFilterSingleValueContainer(resolver: resolver, isNoneIncluded: isNoneIncluded)
        let component = SFFilterSingleValueComponent(title: title, noneItemTitle: noneItemTitle, filter: container)
        return component
    }
}
