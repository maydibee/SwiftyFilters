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

/// A builder for creating keyword-based filter components.
///
/// This class allows you to declaratively define a keyword-based filter component by specifying:
/// - The filtering behavior.
/// - The view representation.
///
/// ### Example
/// ```swift
/// SFKeywordsFilter<Participant>(title: "Remarks")
///     .filter(by: \.remarks) // Filter by the `remarks` property
///     .includeNone(withTitle: "No Remarks")
///     .displayIn { node in
///         ParticipantRemarksFilterView(node: node)
///     }
/// ```
///
public class SFKeywordsFilter<FilteredItem> {
    
    /// The title of the filter component.
    let title: String
    
    /// The filtering behavior.
    ///
    /// If not specified, all input items will be returned, and an assertion failure will be triggered in debug mode.
    ///
    private var filterBehavior: (([FilteredItem], SFFilterKeywordsModel<String>, _ isNoneEnabled: Bool) -> [FilteredItem]) = { inputItems, _, _ in
        assertionFailure("Filter behavior is not set. Call `filterWithBehavior` or `filter` before building the component.")
        return inputItems
    }
    
    /// The view representation of the filter component.
    ///
    /// If not specified, default view will be returned.
    ///
    private var view: ((SFFilterKeywordsNode<FilteredItem, String>) -> any View) = { node in
        return SFFilterKeywordsDefaultView(node: node)
    }
    
    /// A flag indicating whether the "None" option is included in the filter.
    private var isNoneIncluded: Bool = false
    
    /// The title of the "None" option.
    private var noneItemTitle: String = "None"
    
    
    /// Initializes a new keywords filter component with the specified title.
    ///
    /// - Parameter title: The title of the filter component.
    ///
    public init(title: String) {
        self.title = title
    }
    
    /// Sets the filtering behavior.
    ///
    /// - Parameter filter: A closure that defines how input items should be filtered based on criteria item and `isNoneEnabled` value.
    /// - Returns: The modified `SFKeywordsFilter` instance.
    ///
    @discardableResult
    public func filter(_ filter: @escaping ([FilteredItem], SFFilterKeywordsModel<String>, _ isNoneEnabled: Bool) -> [FilteredItem]) -> Self {
        self.filterBehavior = filter
        return self
    }
    
    /// Filters input items based on a key path to a `String` property.
    ///
    /// This method allows you to declaratively specify how input items should be filtered
    /// by comparing a key path of `FilteredItem` with the keywords in `SFFilterKeywordsModel`.
    ///
    /// - Parameter keyPath: A key path to a `String` property in `FilteredItem`.
    /// - Returns: The modified `SFKeywordsFilter` instance.
    ///
    /// ### Example
    /// ```swift
    /// SFKeywordsFilter<Participant>(title: "Remarks")
    ///     .filter(by: \.remarks) // Filter by the `remarks` property
    ///     .includeNone(withTitle: "No Remarks")
    ///     .displayIn { node in
    ///         ParticipantRemarksFilterView(node: node)
    ///     }
    /// ```
    /// 
    @discardableResult
    public func filter(by keyPath: KeyPath<FilteredItem, String>) -> Self {
        self.filterBehavior = { inputItems, criteriaItem, isNoneEnabled in
            return inputItems
                .filter { inputItem in
                    if !inputItem[keyPath: keyPath].isEmpty {
                        return criteriaItem.isSafisfy(inputItem[keyPath: keyPath])
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
    /// - Returns: The modified `SFKeywordsFilter` instance.
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
    /// - Returns: The modified `SFKeywordsFilter` instance.
    ///
    @discardableResult
    public func displayIn(_ view: @escaping (SFFilterKeywordsNode<FilteredItem, String>) -> any View) -> Self {
        self.view = view
        return self
    }
}


// MARK: - SFBuildableComponent implementation

extension SFKeywordsFilter: SFBuildableComponent {
    
    /// Builds the final filter component.
    ///
    /// - Returns: A `SFFilterComponent<FilteredItem>` instance.
    ///
    public func buildComponent() -> SFFilterComponent<FilteredItem> {
        let container = SFFilterKeyWordsContainer(filterBehavior: self.filterBehavior, isNoneIncluded: self.isNoneIncluded)
        let component = SFFilterKeyWordsComponent(title: self.title, noneItemTitle: self.noneItemTitle, filter: container, view: self.view)
        return component
    }
}

