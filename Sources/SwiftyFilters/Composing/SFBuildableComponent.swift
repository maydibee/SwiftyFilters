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

/// A protocol for types that can build a filter component.
///
/// Types conforming to this protocol must implement the `buildComponent` method,
/// which returns a `SFFilterComponent<FilteredItem>` instance.
///
/// ### Example
/// ```swift
/// struct CustomFilterBuilder: SFBuildableComponent {
///     func buildComponent() -> SFFilterComponent<Item> {
///         // Build and return the filter component
///     }
/// }
/// ```
///
public protocol SFBuildableComponent<FilteredItem> {
    
    /// The type of items to be filtered.
    associatedtype FilteredItem
    
    /// Builds the filter component.
    ///
    /// - Returns: A `SFFilterComponent<FilteredItem>` instance.
    ///
    func buildComponent() -> SFFilterComponent<FilteredItem>
}
