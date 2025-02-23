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

/// A container representing a range of comparable values.
///
/// This struct is used as criteria in range-based filters to define a range with optional
/// lower and upper bounds. It provides a method to check if a value falls within the range.
///
/// ### Example of internal usage
/// ```swift
/// let range = SFFilterRange(lowerBound: 5, upperBound: 10)
/// print(range.contains(7)) // true
/// print(range.contains(12)) // false
/// ```
///
public struct SFFilterRange<T: Comparable> {
    
    /// The lower bound of the range. If `nil`, the range has no lower limit.
    public let lowerBound: T?
    
    /// The upper bound of the range. If `nil`, the range has no upper limit.
    public let upperBound: T?
    
    /// Checks if a value falls within the range.
    ///
    /// - Parameter value: The value to check.
    /// - Returns: `true` if the value is within the range, otherwise `false`.
    ///
    public func contains(_ value: T) -> Bool {
        if let lowerBound = lowerBound, value < lowerBound {
            return false
        }
        if let upperBound = upperBound, value > upperBound {
            return false
        }
        return true
    }
}
