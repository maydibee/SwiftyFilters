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


/// A protocol for providing a view that displays a single-value filter component.
///
/// Types conforming to this protocol must provide a view that works with an `SFFilterSingleValueNode<FilteredItem, CriteriaItem>`
/// as its view model. The view model is used to manage the state of the single-value filter component.
///
/// ### Generic Parameters
/// - `FilteredItem`: The type of data being filtered.
/// - `CriteriaItem`: The type used for filtering criteria. Must conform to `Equatable`.
///
/// ### Example
/// ```swift
/// import SwiftUI
/// import SwiftyFilters
///
///
/// struct ParticipantStatusFilterView: View {
///     @StateObject var node: SFFilterSingleValueNode<Participant, ParticipantStatus>
///
///     var body: some View {
///         // View implementation for single-value filter
///     }
/// }
///
/// class ParticipantStatusViewProvider: SFFilterSingleValueViewProvider {
///     func makeView(with node: SFFilterSingleValueNode<Participant, ParticipantStatus>) -> any View {
///         ParticipantStatusFilterView(node: node)
///     }
/// }
/// ```
///
public protocol SFFilterSingleValueViewProvider<FilteredItem, CriteriaItem> where CriteriaItem: Equatable {
    
    associatedtype FilteredItem
    associatedtype CriteriaItem
    
    /// Creates a view for the single-value filter component.
    ///
    /// The view should embed the provided `SFFilterSingleValueNode<FilteredItem, CriteriaItem>` as a `@StateObject`,
    /// which acts as the view model. The view model is used for operations such as selecting a value
    /// or resetting the filter state.
    ///
    /// - Parameter node: The filter node to use as the view model.
    /// - Returns: A view representing the single-value filter component.
    ///
    func makeView(with node: SFFilterSingleValueNode<FilteredItem, CriteriaItem>) -> any View
}
