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


// MARK: - SFGroupedComponent support

extension SFFiltersBuilder {
    
    /// Converts a single `SFGroupedComponent` into an array of `SFFilterComponent`.
    public static func buildExpression(_ expression: SFGroupedComponent<FilteredItem>) -> [SFFilterComponent<FilteredItem>] {
        let components = expression.content()
        return [self.createGroupedItem(title: expression.title, from: components)]
    }
    
    /// Handles optional `SFGroupedComponent`.
    public static func buildOptional(_ component: SFGroupedComponent<FilteredItem>?) -> [SFFilterComponent<FilteredItem>] {
        guard let component = component else { return [] }
        let components = component.content()
        return [self.createGroupedItem(title: component.title, from: components)]
    }
    
    /// Handles the first branch of a conditional statement for `SFGroupedComponent`.
    public static func buildEither(first component: SFGroupedComponent<FilteredItem>) -> [SFFilterComponent<FilteredItem>] {
        let components = component.content()
        return [self.createGroupedItem(title: component.title, from: components)]
    }
    
    /// Handles the second branch of a conditional statement for `SFGroupedComponent`.
    public static func buildEither(second component: SFGroupedComponent<FilteredItem>) -> [SFFilterComponent<FilteredItem>] {
        let components = component.content()
        return [self.createGroupedItem(title: component.title, from: components)]
    }
    
    /// Combines an array of `SFGroupedComponent` into a single array of `SFFilterComponent`.
    public static func buildArray(_ components: [SFGroupedComponent<FilteredItem>]) -> [SFFilterComponent<FilteredItem>] {
        return components.flatMap { component in
            let nestedComponents = component.content()
            return [self.createGroupedItem(title: component.title, from: nestedComponents)]
        }
    }
}


// MARK: - Utility methods

private extension SFFiltersBuilder {
    static func createGroupedItem(title: String, from components: [SFFilterComponent<FilteredItem>]) -> SFFilterMasterComponent<FilteredItem> {
        SFFilterMasterComponent(title: title, nestedFilterItems: components)
    }
}
