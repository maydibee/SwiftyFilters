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


/// A result builder for constructing filter hierarchies.
///
/// This builder allows you to create complex filter trees using a declarative syntax.
/// It is used in conjunction with `SFFiltersCore` and `SFGroupedComponent`.
///
/// ### Example
/// ```swift
/// @SFFiltersBuilder<Landmark>
/// static func buildFilters() -> [SFFilterComponent<Landmark>] {
///     SFGroupedComponent(title: "Category") {
///         categoryFilterComponent
///         subcategoryFilterComponent
///     }
///     distanceRangeFilterComponent
/// }
/// ```
///
@resultBuilder
public struct SFFiltersBuilder<FilteredItem> {
    
    /// Combines multiple arrays of filter components into a single array.
    public static func buildBlock(_ components: [SFFilterComponent<FilteredItem>]...) -> [SFFilterComponent<FilteredItem>] {
        components.flatMap { $0 }
    }
    
    /// Converts a single filter component into an array.
    public static func buildExpression(_ expression: SFFilterComponent<FilteredItem>) -> [SFFilterComponent<FilteredItem>] {
        [expression]
    }
    
    /// Converts an array of filter components into an array.
    public static func buildExpression(_ expression: [SFFilterComponent<FilteredItem>]) -> [SFFilterComponent<FilteredItem>] {
        expression
    }
    
    /// Handles optional arrays of filter components.
    public static func buildOptional(_ components: [SFFilterComponent<FilteredItem>]?) -> [SFFilterComponent<FilteredItem>] {
        components ?? []
    }
    
    /// Handles the first branch of a conditional statement.
    public static func buildEither(first components: [SFFilterComponent<FilteredItem>]) -> [SFFilterComponent<FilteredItem>] {
        components
    }
    
    /// Handles the second branch of a conditional statement.
    public static func buildEither(second components: [SFFilterComponent<FilteredItem>]) -> [SFFilterComponent<FilteredItem>] {
        components
    }
    
    /// Combines an array of arrays of filter components into a single array.
    public static func buildArray(_ components: [[SFFilterComponent<FilteredItem>]]) -> [SFFilterComponent<FilteredItem>] {
        components.flatMap { $0 }
    }
    
    /// Converts a grouped component into an array of filter components.
    public static func buildExpression(_ expression: SFGroupedComponent<FilteredItem>) -> [SFFilterComponent<FilteredItem>] {
        let components = expression.content()
        return [self.createGroupedItem(title: expression.title, from: components)]
    }
}

private extension SFFiltersBuilder {
    
    static func createGroupedItem(title: String, from components: [SFFilterComponent<FilteredItem>]) -> SFFilterMasterComponent<FilteredItem> {
        SFFilterMasterComponent(title: title, nestedFilterItems: components)
    }
}

