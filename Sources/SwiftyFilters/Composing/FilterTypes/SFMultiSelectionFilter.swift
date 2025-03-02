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
///     .fetchItems {
///         await ParticipantRolesFilterFetcher().fetchFilterItems()
///     }
///     .filter { inputItems, criteriaItems in
///         inputItems.filter { inputItem in
///             if let role = inputItem.role {
///                 return criteriaItems.contains { $0.id == role.id }
///             } else {
///                 return true
///             }
///         }
///     }
///     .includeNone(withTitle: "No Role")
///     .displayIn { node in
///         ParticipantRolesFilterView(node: node)
///     }
/// ```
///
public class SFMultiSelectionFilter<FilteredItem, CriteriaItem: Identifiable & SFFiltersTitleable> {
    
    let title: String
    
    // Empty array will be retnrned as criteria items datasource if criteriaItemsDatasource unspecified
    var criteriaItemsDatasource: (() async -> [CriteriaItem]) = {
        assertionFailure("Criteria items datasource is not set. Call `basedOnDatasource` before building the component.")
        return []
    }
    
    // All imput items will be retunted if filterBehavior unspecified
    var filterBehavior: (([FilteredItem], [CriteriaItem], _ isNoneEnabled: Bool) -> [FilteredItem]) = { inputItems, _, _ in
        assertionFailure("Filter behavior is not set. Call `filterWithBehavior` before building the component.")
        return inputItems
    }
    
    // Empty view will be used if view unspecified
    var view: ((SFFilterMultiSelectionNode<FilteredItem>) -> any View) = { _ in
        assertionFailure("View provider is not set. Call `presentWithin` before building the component.")
        return EmptyView()
    }
    
    private var isNoneIncluded: Bool = false
    private var noneItemTitle: String = "None"
    
    
    public init(title: String) {
        self.title = title
    }
    
    @discardableResult
    public func fetchItems(_ fetch: @escaping () async -> [CriteriaItem]) -> Self {
        self.criteriaItemsDatasource = fetch
        return self
    }
    
    @discardableResult
    public func filter(_ filter: @escaping ([FilteredItem], [CriteriaItem], _ isNoneEnabled: Bool) -> [FilteredItem]) -> Self {
        self.filterBehavior = filter
        return self
    }
    
    @discardableResult
    public func includeNone(withTitle title: String) -> Self {
        self.isNoneIncluded = true
        self.noneItemTitle = title
        return self
    }
    
    @discardableResult
    public func displayIn(_ view: @escaping (SFFilterMultiSelectionNode<FilteredItem>) -> any View) -> Self {
        self.view = view
        return self
    }
}

// MARK: - SFFilterBuildableComponent implementation

extension SFMultiSelectionFilter: SFFilterBuildableComponent {
    
    public func buildComponent() -> SFFilterComponent<FilteredItem> {
        let container = SFFilterMultiSelectionContainer(criteriaItemsDatasource: criteriaItemsDatasource, filterBehavior: filterBehavior, isNoneIncluded: isNoneIncluded)
        let component = SFFilterMultiSelectionComponent(title: self.title, noneItemTitle: self.noneItemTitle, filter: container, view: view)
        return component
    }
}
