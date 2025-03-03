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


// MARK: - SFBuildableComponent support

extension SFFiltersBuilder {
    
    /// Converts a single `SFBuildableComponent` into an array of `SFFilterComponent`.
    public static func buildExpression(_ expression: any SFBuildableComponent<FilteredItem>) -> [SFFilterComponent<FilteredItem>] {
        let component = expression.buildComponent()
        return [component]
    }
    
    /// Handles optional `SFBuildableComponent`.
    public static func buildOptional(_ component: (any SFBuildableComponent<FilteredItem>)?) -> [SFFilterComponent<FilteredItem>] {
        guard let component = component else { return [] }
        return [component.buildComponent()]
    }
    
    /// Handles the first branch of a conditional statement for `SFBuildableComponent`.
    public static func buildEither(first component: any SFBuildableComponent<FilteredItem>) -> [SFFilterComponent<FilteredItem>] {
        return [component.buildComponent()]
    }
    
    /// Handles the second branch of a conditional statement for `SFBuildableComponent`.
    public static func buildEither(second component: any SFBuildableComponent<FilteredItem>) -> [SFFilterComponent<FilteredItem>] {
        return [component.buildComponent()]
    }
    
    /// Combines an array of `SFBuildableComponent` into a single array of `SFFilterComponent`.
    @available(iOS 16.0.0, *)
    public static func buildArray(_ components: [any SFBuildableComponent<FilteredItem>]) -> [SFFilterComponent<FilteredItem>] {
        return components.map { $0.buildComponent() }
    }
}
