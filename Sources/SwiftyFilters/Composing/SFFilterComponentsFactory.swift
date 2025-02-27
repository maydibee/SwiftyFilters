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


/// A factory class for creating filter components of different types.
///
/// This class provides static methods to create filter components for:
/// - Multi-selection filters
/// - Range filters
/// - Keywords filters
/// - Single value filters
///
/// Each method returns a `SFFilterComponent` configured with the specified parameters.
///
public class SFFilterComponentsFactory {
    
    /// Creates a multi-selection filter component.
    ///
    /// This component allows filtering based on multiple criteria of type `CriteriaItem`
    /// or the absence of a value (if `isNoneIncluded` is `true`).
    ///
    /// - Parameters:
    ///   - title: The title of the filter component.
    ///   - resolver: An object conforming to `SFFilterResolver` that defines the filtering behavior
    ///              based on an array of `CriteriaItem`.
    ///   - fetcher: An object conforming to `SFFilterFetcher` that fetches the data source for the filter.
    ///   - isNoneIncluded: A flag indicating whether the "None" option is included in the filter.
    ///                     Defaults to `false`.
    ///   - noneItemTitle: The title of the "None" option, displayed if `isNoneIncluded` is `true`.
    ///
    /// - Returns: A configured `SFFilterComponent` for multi-selection filtering.
    ///
    public static func createMultiSelectionComponent<FilteredItem, CriteriaItem: Identifiable & SFFiltersTitleable>(title: String,
                                                                                                                    resolver: any SFFilterResolver<FilteredItem, [CriteriaItem]>,
                                                                                                                    fetcher: any SFFilterFetcher<CriteriaItem>,
                                                                                                                    viewProvider: any SFFilterMultiSelectionViewProvider<FilteredItem> = SFFilterMultiSelectionDefaultViewProvider(),
                                                                                                                    isNoneIncluded: Bool = false,
                                                                                                                    noneItemTitle: String) -> SFFilterComponent<FilteredItem> {
        let container = SFFilterMultiSelectionContainer(resolver: resolver, fetcher: fetcher, isNoneIncluded: isNoneIncluded)
        let component = SFFilterMultiSelectionComponent(title: title, noneItemTitle: noneItemTitle, filter: container, viewProvider: viewProvider)
        return component
    }
    
    /// Creates a range filter component.
    ///
    /// This component allows filtering based on a range of values or the absence of a value
    /// (if `isNoneIncluded` is `true`).
    ///
    /// - Parameters:
    ///   - title: The title of the filter component.
    ///   - resolver: An object conforming to `SFFilterResolver` that defines the filtering behavior
    ///              based on a `SFFilterRange<CriteriaItem>`.
    ///   - isNoneIncluded: A flag indicating whether the "None" option is included in the filter.
    ///                     Defaults to `false`.
    ///   - noneItemTitle: The title of the "None" option, displayed if `isNoneIncluded` is `true`.
    ///
    /// - Returns: A configured `SFFilterComponent` for range-based filtering.
    ///
    public static func createRangeComponent<FilteredItem, CriteriaItem: Comparable>(title: String,
                                                                                    resolver: any SFFilterResolver<FilteredItem, SFFilterRange<CriteriaItem>>,
                                                                                    viewProvider: any SFFilterRangeViewProvider<FilteredItem, CriteriaItem>,
                                                                                    isNoneIncluded: Bool = false,
                                                                                    noneItemTitle: String) -> SFFilterComponent<FilteredItem> {
        let container = SFFilterRangeContainer(resolver: resolver, isNoneIncluded: isNoneIncluded)
        let component = SFFilterRangeComponent(title: title, noneItemTitle: noneItemTitle, filter: container, viewProvider: viewProvider)
        return component
    }
    
    /// Creates a keywords filter component.
    ///
    /// This component allows filtering based on a set of keywords or the absence of a value
    /// (if `isNoneIncluded` is `true`).
    ///
    /// - Parameters:
    ///   - title: The title of the filter component.
    ///   - resolver: An object conforming to `SFFilterResolver` that defines the filtering behavior
    ///              based on a `SFFilterKeywordsModel<CriteriaItem>`.
    ///   - isNoneIncluded: A flag indicating whether the "None" option is included in the filter.
    ///                     Defaults to `false`.
    ///   - noneItemTitle: The title of the "None" option, displayed if `isNoneIncluded` is `true`.
    ///
    /// - Returns: A configured `SFFilterComponent` for keyword-based filtering.
    ///
    public static func createKeywordsComponent<FilteredItem>(title: String,
                                                                                           resolver: any SFFilterResolver<FilteredItem, SFFilterKeywordsModel<String>>,
                                                                                           viewProvider: any SFFilterKeywordsViewProvider<FilteredItem, String> = SFFilterKeywordsDefaultViewProvider(),
                                                                                           isNoneIncluded: Bool = false,
                                                                                           noneItemTitle: String) -> SFFilterComponent<FilteredItem> {
        let container = SFFilterKeyWordsContainer(resolver: resolver, isNoneIncluded: isNoneIncluded)
        let component = SFFilterKeyWordsComponent(title: title, noneItemTitle: noneItemTitle, filter: container, viewProvider: viewProvider)
        return component
    }
    
    /// Creates a single value filter component.
    ///
    /// This component allows filtering based on a specific value or the absence of a value
    /// (if `isNoneIncluded` is `true`).
    ///  - Parameters:
    ///    - title: The title of the filter component.
    ///    - resolver: An object conforming to `SFFilterResolver` that defines the filtering behavior
    ///              based on a single `CriteriaItem`.
    ///    - isNoneIncluded: A flag indicating whether the "None" option is included in the filter.
    ///                     Defaults to `false`.
    ///    - noneItemTitle: The title of the "None" option, displayed if `isNoneIncluded` is `true`.
    ///
    /// - Returns: A configured `SFFilterComponent` for single value-based filtering.
    ///
    public static func createSingleValueComponent<FilteredItem, CriteriaItem: Equatable>(title: String,
                                                                                         resolver: any SFFilterResolver<FilteredItem, CriteriaItem>,
                                                                                         viewProvider: any SFFilterSingleValueViewProvider<FilteredItem, CriteriaItem>,
                                                                                         isNoneIncluded: Bool = false,
                                                                                         noneItemTitle: String) -> SFFilterComponent<FilteredItem> {
        let container = SFFilterSingleValueContainer(resolver: resolver, isNoneIncluded: isNoneIncluded)
        let component = SFFilterSingleValueComponent(title: title, noneItemTitle: noneItemTitle, filter: container, viewProvider: viewProvider)
        return component
    }
}
