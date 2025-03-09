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


/// A component that groups multiple filter components under a single title.
///
/// This struct is used to create hierarchical filter structures. It allows you to group related filters
/// together and display them under a common title within separate filter branch component view.
///
/// ### Example
/// ```swift
///
///SFGroupedComponent(title: "Age") {
///
///    // MARK: Manufacture date filter
///
///    SFRangeFilter(title: "Manufacture date")
///        .filter(by: \.manufactureDate)
///        .displayIn { node in
///            SFFilterDateRangeView(node: node)
///        }
///
///    // MARK: Newness filter
///
///    SFSingleValueFilter(title: "Is new")
///        .filter(by: \.isNew)
///        .displayIn { node in
///            BooleanOptionFilterView(node: node)
///        }
///}
/// ```
///
public struct SFGroupedComponent<FilteredItem> {
    
    /// The title of the grouped component.
    let title: String

    /// A result builder that constructs the content of the grouped component.
    @SFFiltersBuilder<FilteredItem> let content: () -> [SFFilterComponent<FilteredItem>]
    
    /// Initializes a new grouped component.
    ///
    /// - Parameters:
    ///   - title: The title of the grouped component.
    ///   - content: A result builder that constructs the content of the grouped component.
    ///
    public init(title: String, @SFFiltersBuilder<FilteredItem> content: @escaping () -> [SFFilterComponent<FilteredItem>]) {
        self.title = title
        self.content = content
    }
}
