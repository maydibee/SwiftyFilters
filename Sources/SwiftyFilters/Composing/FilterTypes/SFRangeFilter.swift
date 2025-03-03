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


import SwiftUI


public class SFRangeFilter<FilteredItem, CriteriaItem: Comparable> {
    
    /// The title of the filter component.
    let title: String
    
    /// The filtering behavior.
    ///
    /// If not specified, all input items will be returned, and an assertion failure will be triggered in debug mode.
    ///
    private var filterBehavior: (([FilteredItem], SFFilterRange<CriteriaItem>, _ isNoneEnabled: Bool) -> [FilteredItem]) = { inputItems, _, _ in
        assertionFailure("Filter behavior is not set. Call `filterWithBehavior` or `filter` before building the component.")
        return inputItems
    }
    
    /// The view representation of the filter component.
    ///
    /// If not specified, empty view will be returned, and an assertion failure will be triggered in debug mode.
    ///
    private var view: ((SFFilterRangeNode<FilteredItem, CriteriaItem>) -> any View) = { _ in
        assertionFailure("Filter view is not set. Call `displayIn` before building the component.")
        return EmptyView()
    }
    
    /// A flag indicating whether the "None" option is included in the filter.
    private var isNoneIncluded: Bool = false
    
    /// The title of the "None" option.
    private var noneItemTitle: String = "None"
    
    
    /// Initializes a new multi-selection filter component with the specified title.
    ///
    /// - Parameter title: The title of the filter component.
    ///
    public init(title: String) {
        self.title = title
    }
    
    /// Sets the filtering behavior.
    ///
    /// - Parameter filter: A closure that defines how input items should be filtered based on criteria items and isNoneEnabled value.
    /// - Returns: The modified `SFMultiSelectionFilter` instance.
    ///
    @discardableResult
    public func filter(_ filter: @escaping ([FilteredItem], SFFilterRange<CriteriaItem>, _ isNoneEnabled: Bool) -> [FilteredItem]) -> Self {
        self.filterBehavior = filter
        return self
    }
    
    
    @discardableResult
    public func filter(by keyPath: KeyPath<FilteredItem, CriteriaItem>) -> Self {
        self.filterBehavior = { inputItems, criteriaItem, isNoneEnabled in
            return inputItems
                .filter { inputItem in
                    criteriaItem.contains(inputItem[keyPath: keyPath])
                }
        }
        return self
    }
    
    
    @discardableResult
    public func filter(byOptional keyPath: KeyPath<FilteredItem, CriteriaItem?>) -> Self {
        self.filterBehavior = { inputItems, criteriaItem, isNoneEnabled in
            return inputItems
                .filter { inputItem in
                    if let value = inputItem[keyPath: keyPath] {
                        return criteriaItem.contains(value)
                    } else {
                        return isNoneEnabled
                    }
                }
        }
        return self
    }
    
    /// Includes a "None" option in the filter.
    ///
    /// - Parameter title: The title of the "None" option.
    /// - Returns: The modified `SFRangeFilter` instance.
    ///
    @discardableResult
    public func includeNone(withTitle title: String) -> Self {
        self.isNoneIncluded = true
        self.noneItemTitle = title
        return self
    }
    
    /// Sets the view representation of the filter component.
    ///
    /// - Parameter view: A closure that returns a view for the filter component.
    /// - Returns: The modified `SFRangeFilter` instance.
    ///
    @discardableResult
    public func displayIn(_ view: @escaping ((SFFilterRangeNode<FilteredItem, CriteriaItem>) -> any View)) -> Self {
        self.view = view
        return self
    }
}
