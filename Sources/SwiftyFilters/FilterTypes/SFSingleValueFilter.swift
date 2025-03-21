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


/// A builder for creating single-value filter components.
///
/// This class allows you to declaratively define a single-value filter component by specifying:
/// - The filtering behavior.
/// - The view representation.
///
/// ### Example
/// ```swift
/// SFSingleValueFilter(title: "Status")
///     .filter(byOptional: \.status) // Filter by the optional `status` property
///     .includeNone(withTitle: "No Status")
///     .displayIn { node in
///         ParticipantStatusFilterView(node: node)
///     }
/// ```
///
public final class SFSingleValueFilter<FilteredItem, CriteriaItem: Equatable> {
    
    /// The title of the filter component.
    let title: String
    
    /// The filtering behavior.
    ///
    /// If not specified, all input items will be returned, and an assertion failure will be triggered in debug mode.
    ///
    private(set) var filterBehavior: (([FilteredItem], CriteriaItem, _ isNoneEnabled: Bool) -> [FilteredItem]) = { inputItems, _, _ in
        assertionFailure("Filter behavior is not set. Call `filterWithBehavior` or `filter` before building the component.")
        return inputItems
    }
    
    /// The view representation of the filter component.
    ///
    /// If not specified, empty view will be returned, and an assertion failure will be triggered in debug mode.
    ///
    private(set) var view: ((SFFilterSingleValueNode<FilteredItem, CriteriaItem>) -> any View) = { _ in
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
    /// - Returns: The modified `SFSingleValueFilter` instance.
    ///
    @discardableResult
    public func filter(_ filter: @escaping ([FilteredItem], CriteriaItem, _ isNoneEnabled: Bool) -> [FilteredItem]) -> Self {
        self.filterBehavior = filter
        return self
    }
    
    /// Filters input items based on a key path to a `CriteriaItem` property.
    ///
    /// This method allows you to declaratively specify how input items should be filtered
    /// by comparing a key path of `FilteredItem` with the criteria item.
    ///
    /// - Parameter keyPath: A key path to a `CriteriaItem` property in `FilteredItem`.
    /// - Returns: The modified `SFSingleValueFilter` instance.
    ///
    /// ### Example
    /// ```swift
    /// SFSingleValueFilter(title: "Status")
    ///     .filter(by: \.status) // Filter by the `status` property
    ///     .displayIn { node in
    ///         ParticipantStatusFilterView(node: node)
    ///     }
    /// ```
    ///
    @discardableResult
    public func filter(by keyPath: KeyPath<FilteredItem, CriteriaItem>) -> Self {
        self.filterBehavior = { inputItems, criteriaItem, isNoneEnabled in
            return inputItems
                .filter { inputItem in
                    inputItem[keyPath: keyPath] == criteriaItem
                }
        }
        return self
    }
    
    /// Filters input items based on a key path to an optional `CriteriaItem` property.
    ///
    /// This method allows you to declaratively specify how input items should be filtered
    /// by comparing a key path of `FilteredItem` with the criteria item.
    /// If the property is `nil`, the item will be included only if `isNoneEnabled` is `true`.
    ///
    /// - Parameter keyPath: A key path to an optional `CriteriaItem` property in `FilteredItem`.
    /// - Returns: The modified `SFSingleValueFilter` instance.
    ///
    /// ### Example
    /// ```swift
    /// SFSingleValueFilter(title: "Status")
    ///     .filter(byOptional: \.status) // Filter by the optional `status` property
    ///     .includeNone(withTitle: "No Status")
    ///     .displayIn { node in
    ///         ParticipantStatusFilterView(node: node)
    ///     }
    /// ```
    ///
    @discardableResult
    public func filter(byOptional keyPath: KeyPath<FilteredItem, CriteriaItem?>) -> Self {
        self.filterBehavior = { inputItems, criteriaItem, isNoneEnabled in
            return inputItems
                .filter { inputItem in
                    if let value = inputItem[keyPath: keyPath] {
                        return value == criteriaItem
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
    /// - Returns: The modified `SFSingleValueFilter` instance.
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
    /// - Returns: The modified `SFSingleValueFilter` instance.
    ///
    @discardableResult
    public func displayIn(_ view: @escaping ((SFFilterSingleValueNode<FilteredItem, CriteriaItem>) -> any View)) -> Self {
        self.view = view
        return self
    }
}


// MARK: - SFBuildableComponent implementation

extension SFSingleValueFilter: SFBuildableComponent {
    
    /// Builds the final filter component.
    ///
    /// - Returns: A `SFFilterComponent<FilteredItem>` instance.
    ///
    public func buildComponent() -> SFFilterComponent<FilteredItem> {
        let container = SFFilterSingleValueContainer(filterBehavior: self.filterBehavior, isNoneIncluded: self.isNoneIncluded)
        let component = SFFilterSingleValueComponent(title: self.title, noneItemTitle: self.noneItemTitle, filter: container, view: self.view)
        return component
    }
}
