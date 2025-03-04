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


/// A protocol that defines a filter component, which can be used to build complex filters.
///
/// Types conforming to this protocol can represent either individual filter components
/// or root filters that can be used in the `body` of another `SFFilter`
/// or during the initialization of `SFFiltersCore`.
///
/// ### Generic Parameters
/// - `FilteredItem`: The type of data being filtered.
///
/// ### Example
/// ```swift
/// import SwiftyFilters
///
///struct AircraftDatesFilter: SFFilter {
///
///    var body: [SFFilterComponent<Aircraft>] {
///
///        // MARK: - Dates section
///
///        SFGroupedComponent(title: "Dates") {
///
///            // MARK: First flight date filter
///
///            SFRangeFilter(title: "First flight date")
///                .filter(by: \.firstFlightDate)
///                .displayIn { node in
///                    SFFilterDateRangeView(node: node)
///                }
///
///            // MARK: - Aircraft age section
///
///            SFGroupedComponent(title: "Age") {
///
///                // MARK: Manufacture date filter
///
///                SFRangeFilter(title: "Manufacture date")
///                    .filter(by: \.manufactureDate)
///                    .displayIn { node in
///                        SFFilterDateRangeView(node: node)
///                    }
///
///                // MARK: Newness filter
///
///                SFSingleValueFilter<Aircraft, Bool>(title: "Newness")
///                    .filter(by: \.isNew)
///                    .displayIn { node in
///                        BooleanOptionFilterView(node: node)
///                    }
///            }
///
///        }
///    }
///}
/// ```
///
public protocol SFFilter<FilteredItem> {
    
    /// The type of items to be filtered.
    associatedtype FilteredItem
    
    
    /// The body of the filter, represented as an array of filter components.
    ///
    /// This is used to build complex filters using `SFFiltersBuilder` result builder.
    ///
    @SFFiltersBuilder<FilteredItem> var body: [SFFilterComponent<FilteredItem>] { get }
}
