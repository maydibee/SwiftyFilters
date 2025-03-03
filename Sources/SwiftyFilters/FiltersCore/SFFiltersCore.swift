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
import Combine
import SwiftUI


/// The main entry point for working with filters in client code.
///
/// This class allows client code to be informed when filters are active, build complex multi-level
/// filter hierarchies using the `@SFFiltersBuilder` result builder, and participate in filtering data
/// by traversing the entire filter component tree.
///
/// ### Example
/// ```swift
/// let filtersCore = SFFiltersCore<Landmark>(title: "Filters") {
///     SFGroupedComponent(title: "Category") {
///         categoryFilterComponent
///         subcategoryFilterComponent
///     }
///     distanceRangeFilterComponent
/// }
/// ```
///
public class SFFiltersCore<FilteredItem>: ObservableObject {

    /// The title of the filter tree, which can be used for display purposes (e.g., in a navigation bar).
    public let title: String
    
    /// The root node of the filter tree.
    ///
    /// This property represents the top-level node of the filter hierarchy. It can be used for customizing
    /// behavior or creating a custom filter core. In most cases, it does not need to be accessed directly.
    ///
    @Published public var rootNode: SFFilterNode<FilteredItem>? {
        didSet {
            subscribeToIsItemEnabled()
        }
    }
    
    /// Indicates whether the filter is active (i.e., whether any filter component affects the filtering).
    ///
    @Published public var isFilterActive: Bool = false

    
    private var filters: [SFFilterComponent<FilteredItem>]
    private var cancellables = Set<AnyCancellable>()
    
    /// Initializes a new `SFFiltersCore` instance.
    ///
    /// - Parameters:
    ///   - title: The title of the filter tree.
    ///   - builder: A result builder (`@SFFiltersBuilder`) used to construct the filter hierarchy.
    ///
    public init(title: String, @SFFiltersBuilder<FilteredItem> builder: () -> [SFFilterComponent<FilteredItem>]) {
        self.title = title
        self.filters = builder()
    }
    
    
    /// Initializes a new `SFFiltersCore` instance.
    ///
    /// - Parameters:
    ///   - title: The title of the filter tree.
    ///   - content: Root filter component, an implementation of `SFFilter`.
    ///
    public init(title: String, content: any SFFilter<FilteredItem>) {
        self.title = title
        self.filters = content.body
    }
    
    /// Filters the provided data based on the current state of the filter tree.
    ///
    /// - Parameter items: The data to be filtered.
    /// - Returns: The filtered data.
    ///
    public func getFilteredData(from items: [FilteredItem]) -> [FilteredItem] {
        guard let rootNode else { return items }
        return rootNode.getFilteredData(from: items)
    }
    
    /// Resets all filters in filter tree.
    ///
    public func resetFilters() {
        rootNode?.resetAllFilters()
    }
    
    func compose() {
        let filterComponents: [SFFilterComponent<FilteredItem>] = filters
        let master = SFFilterMasterComponent(title: self.title, nestedFilterItems: filterComponents)
        self.rootNode = SFFilterNode(component: master)
    }
    
    public func createT() {}
}


// MARK: - Subscriptions configuration

private extension SFFiltersCore {
    
    private func subscribeToIsItemEnabled() {
        cancellables.removeAll()
        
        rootNode?.$isItemEnabled
            .map { !$0 }
            .assign(to: \.isFilterActive, on: self)
            .store(in: &cancellables)
    }
}
