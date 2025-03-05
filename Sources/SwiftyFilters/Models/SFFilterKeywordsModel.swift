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


/// A container for managing keywords used in keyword-based filters.
///
/// This struct stores a collection of keywords and provides utility methods for working with them.
/// It also includes a method to check if a value satisfies all the keywords in the container.
///
/// ### Example of internal usage
/// ```swift
/// var model = SFFilterKeywordsModel<String>()
/// model.addKeyword("apple")
/// model.addKeyword("banana")
/// print(model.isSafisfy("I like apples and bananas")) // true
/// ```
///
public struct SFFilterKeywordsModel<T: StringProtocol> {
    
    var keywordsContainer: SFFilterKeywords<T> = .init()
    var isCaseSensitive: Bool = false
    
    var isEmpty: Bool {
        keywordsContainer.words.isEmpty
    }
    
    var words: [T] {
        keywordsContainer.words
    }

    /// Checks if a value satisfies all the keywords in the container.
    ///
    /// This method determines whether the provided value contains all the keywords stored in the container.
    /// The comparison can be case-sensitive or case-insensitive, depending on the `isCaseSensitive` internal property.
    ///
    /// - Parameter value: The value to check against the keywords.
    /// - Returns: `true` if the value contains all the keywords, otherwise `false`.
    ///
    public func isSafisfy(_ value: T) -> Bool {
        keywordsContainer.isSafisfy(value, isCaseSensitive: self.isCaseSensitive)
    }
    
    mutating func addKeyword(_ keyword: T) {
        keywordsContainer.words.append(keyword)
    }
    
    mutating func addKeywords(_ keywords: [T]) {
        keywordsContainer.words.append(contentsOf: keywords)
    }
    
    mutating func removeKeyword(at index: Int) {
        keywordsContainer.words.remove(at: index)
    }
    
    mutating func reset() {
        keywordsContainer.words.removeAll()
        isCaseSensitive = false
    }
}
