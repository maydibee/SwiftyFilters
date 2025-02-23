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


/// A type responsible for defining the filtering behavior of a filter component.
///
/// This protocol defines a method to filter an array of `FilteredItem` elements based on
/// the provided `CriteriaItem` and additional parameters like `isNoneEnabled`.
///
/// ### Example
/// ```swift
/// struct Participant {
///     var name: String
///     var age: Int?
/// }
///
///
/// class ParticipantsFilterResolver: SFFilterResolver {
///     
///     func filterItems(
///         _ inputItems: [Participant],
///         basedOn criteriaItem: Int,
///         isNoneEnabled: Bool
///     ) -> [Participant] {
///         return inputItems.filter { participant in
///             if let age = participant.age {
///                 return participant.age == criteriaItem
///             } else {
///                 return isNoneEnabled
///             }
///         }
///     }
/// }
/// ```
///
public protocol SFFilterResolver<FilteredItem, CriteriaItem> {

    /// The type of items to be filtered.
    associatedtype FilteredItem
    
    /// The type of criteria used for filtering.
    associatedtype CriteriaItem

    /// Filters an array of `FilteredItem` elements based on the provided criteria.
    ///
    /// This method defines the filtering behavior. Implementations should return a filtered
    /// array of `FilteredItem` elements based on the `criteriaItem` and `isNoneEnabled` flag.
    ///
    /// - Parameters:
    ///   - inputItems: The array of items to be filtered.
    ///   - criteriaItem: The criteria used for filtering.
    ///   - isNoneEnabled: A flag indicating whether the "None" option is enabled(`false` by default if `isNoneIncluded` isn't set or equal to `false` in component's container )
    ///
    /// - Returns: A filtered array of `FilteredItem` elements.
    ///
    func filterItems(_ inputItems: [FilteredItem], basedOn criteriaItem: CriteriaItem, isNoneEnabled: Bool ) -> [FilteredItem]
}
