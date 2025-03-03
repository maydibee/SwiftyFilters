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


/// A builder for creating multi-selection filter components.
///
/// This class allows you to declaratively define a multi-selection filter component by specifying:
/// - The data source for criteria items.
/// - The filtering behavior.
/// - The view representation.
///
/// ### Example
/// ```swift
/// SFMultiSelectionFilter<Participant, ParticipantRole>(title: "Roles")
///    .fetchItems {
///        await ParticipantRolesFilterFetcher().fetchFilterItems()
///    }
///    .filter(byOptional: \.role?.id)
///    .includeNone(withTitle: "No Role")
///    .displayIn { node in
///        ParticipantRolesFilterView(node: node)
///    }
/// ```
///
public class SFMultiSelectionFilter<FilteredItem, CriteriaItem: Identifiable & SFFiltersTitleable> {
    
    /// The title of the filter component.
    let title: String
    
    /// The data source for criteria items.
    ///
    /// If not specified, an empty array will be returned, and an assertion failure will be triggered in debug mode.
    ///
    private var criteriaItemsDatasource: (() async -> [CriteriaItem]) = {
        assertionFailure("Criteria items datasource is not set. Call `basedOnDatasource` before building the component.")
        return []
    }
    
    /// The filtering behavior.
    ///
    /// If not specified, all input items will be returned, and an assertion failure will be triggered in debug mode.
    ///
    private var filterBehavior: (([FilteredItem], [CriteriaItem], _ isNoneEnabled: Bool) -> [FilteredItem]) = { inputItems, _, _ in
        assertionFailure("Filter behavior is not set. Call `filterWithBehavior` before building the component.")
        return inputItems
    }
    
    /// The view representation of the filter component.
    ///
    /// If not specified, an empty view will be returned, and an assertion failure will be triggered in debug mode.
    ///
    private var view: ((SFFilterMultiSelectionNode<FilteredItem>) -> any View) = { _ in
        assertionFailure("View provider is not set. Call `presentWithin` before building the component.")
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
    
    
    /// Sets the data source for criteria items.
    ///
    /// - Parameter fetch: A closure that asynchronously fetches the criteria items.
    /// - Returns: The modified `SFMultiSelectionFilter` instance.
    ///
    @discardableResult
    public func fetchItems(_ fetch: @escaping () async -> [CriteriaItem]) -> Self {
        self.criteriaItemsDatasource = fetch
        return self
    }
    
    /// Sets the filtering behavior.
    ///
    /// - Parameter filter: A closure that defines how input items should be filtered based on criteria items and isNoneEnabled value.
    /// - Returns: The modified `SFMultiSelectionFilter` instance.
    ///
    @discardableResult
    public func filter(_ filter: @escaping ([FilteredItem], [CriteriaItem], _ isNoneEnabled: Bool) -> [FilteredItem]) -> Self {
        self.filterBehavior = filter
        return self
    }
    
    /// Filters input items based on a key path to a non-optional `CriteriaItem.ID` property.
    ///
    /// This method allows you to declaratively specify how input items should be filtered
    /// by comparing a key path of `FilteredItem` with the `id` of `CriteriaItem`.
    ///
    /// - Parameter keyPath: A key path to a non-optional `CriteriaItem.ID` property in `FilteredItem`.
    /// - Returns: The modified `SFMultiSelectionFilter` instance.
    ///
    /// ### Example
    /// ```swift
    /// SFMultiSelectionFilter<Participant, ParticipantRole>(title: "Roles")
    ///     .fetchItems {
    ///         await ParticipantRolesFilterFetcher().fetchFilterItems()
    ///     }
    ///     .filter(by: \.role.id) // Filter by the `id` of the `role` property
    ///     .displayIn { node in
    ///         ParticipantRolesFilterView(node: node)
    ///     }
    /// ```
    ///
    @discardableResult
    public func filter(by keyPath: KeyPath<FilteredItem, CriteriaItem.ID>) -> Self {
        self.filterBehavior = { inputItems, criteriaItems, _ in
            inputItems.filter { inputItem in
                criteriaItems.contains { $0.id == inputItem[keyPath: keyPath] }
            }
        }
        return self
    }
    
    /// Filters input items based on a key path to an optional `CriteriaItem.ID` property.
    ///
    /// This method allows you to declaratively specify how input items should be filtered
    /// by comparing a key path of `FilteredItem` with the `id` of `CriteriaItem`.
    /// If the property is `nil`, the item will be included only if `isNoneEnabled` is `true`.
    ///
    /// - Note: Value of `isNoneEnabled` will be always false and all items with the `nil` property will not be included if "None" option isn't included by `includeNone` method calling.
    ///
    /// - Parameter keyPath: A key path to an optional `CriteriaItem.ID` property in `FilteredItem`.
    /// - Returns: The modified `SFMultiSelectionFilter` instance.
    ///
    /// ### Example
    /// ```swift
    /// SFMultiSelectionFilter<Participant, ParticipantRole>(title: "Roles")
    ///     .fetchItems {
    ///         await ParticipantRolesFilterFetcher().fetchFilterItems()
    ///     }
    ///     .filter(byOptional: \.role?.id) // Filter by the optional `id` of the `role` property
    ///     .includeNone(withTitle: "No Role")
    ///     .displayIn { node in
    ///         ParticipantRolesFilterView(node: node)
    ///     }
    /// ```
    ///
    @discardableResult
    public func filter(byOptional keyPath: KeyPath<FilteredItem, CriteriaItem.ID?>) -> Self {
        self.filterBehavior = { inputItems, criteriaItems, isNoneEnabled in
            inputItems.filter { inputItem in
                if let id = inputItem[keyPath: keyPath] {
                    return criteriaItems.contains { $0.id == id }
                } else {
                    return isNoneEnabled
                }
            }
        }
        return self
    }
    
    /// Filters input items based on a key path to an array of `CriteriaItem.ID` properties.
    ///
    /// This method allows you to declaratively specify how input items should be filtered
    /// by comparing a key path of `FilteredItem` (which is an array of `CriteriaItem.ID`)
    /// with the `id` of `CriteriaItem`.
    /// If the property is an empty array, the item will be included only if `isNoneEnabled` is `true`.
    ///
    /// - Note: Value of `isNoneEnabled` will be always false and all items with the `nil` property will not be included if "None" option isn't included by `includeNone` method calling.
    ///
    /// - Parameter keyPath: A key path to an array of `CriteriaItem.ID` properties in `FilteredItem`.
    /// - Returns: The modified `SFMultiSelectionFilter` instance.
    ///
    /// ### Example
    /// ```swift
    /// SFMultiSelectionFilter<Participant, ParticipantRole>(title: "Roles")
    ///     .fetchItems {
    ///         await ParticipantRolesFilterFetcher().fetchFilterItems()
    ///     }
    ///     .filter(byArray: \.roleIds) // Filter by the array of `roleIds`
    ///     .displayIn { node in
    ///         ParticipantRolesFilterView(node: node)
    ///     }
    /// ```
    ///
    @discardableResult
    public func filter(byArray keyPath: KeyPath<FilteredItem, [CriteriaItem.ID]>) -> Self {
        self.filterBehavior = { inputItems, criteriaItems, isNoneEnabled in
            inputItems.filter { inputItem in
                if !inputItem[keyPath: keyPath].isEmpty {
                    return criteriaItems.contains { criteriaItem in
                        inputItem[keyPath: keyPath].contains(criteriaItem.id)
                    }
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
    /// - Returns: The modified `SFMultiSelectionFilter` instance.
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
    /// - Returns: The modified `SFMultiSelectionFilter` instance.
    ///
    @discardableResult
    public func displayIn(_ view: @escaping (SFFilterMultiSelectionNode<FilteredItem>) -> any View) -> Self {
        self.view = view
        return self
    }
}

// MARK: - SFBuildableComponent implementation

extension SFMultiSelectionFilter: SFBuildableComponent {
    
    /// Builds the final filter component.
    ///
    /// - Returns: A `SFFilterComponent<FilteredItem>` instance.
    ///
    public func buildComponent() -> SFFilterComponent<FilteredItem> {
        let container = SFFilterMultiSelectionContainer(criteriaItemsDatasource: criteriaItemsDatasource, filterBehavior: filterBehavior, isNoneIncluded: isNoneIncluded)
        let component = SFFilterMultiSelectionComponent(title: self.title, noneItemTitle: self.noneItemTitle, filter: container, view: view)
        return component
    }
}
