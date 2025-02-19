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


// MARK: - Filters hierarchy builder

@resultBuilder
public struct SFFiltersBuilder<FilteredItem> {
    
    public static func buildBlock(_ components: [SFFilterComponent<FilteredItem>]...) -> [SFFilterComponent<FilteredItem>] {
        components.flatMap { $0 }
    }
    
    public static func buildExpression(_ expression: SFFilterComponent<FilteredItem>) -> [SFFilterComponent<FilteredItem>] {
        [expression]
    }
    
    public static func buildExpression(_ expression: [SFFilterComponent<FilteredItem>]) -> [SFFilterComponent<FilteredItem>] {
        expression
    }
    
    public static func buildOptional(_ components: [SFFilterComponent<FilteredItem>]?) -> [SFFilterComponent<FilteredItem>] {
        components ?? []
    }
    
    public static func buildEither(first components: [SFFilterComponent<FilteredItem>]) -> [SFFilterComponent<FilteredItem>] {
        components
    }
    
    public static func buildEither(second components: [SFFilterComponent<FilteredItem>]) -> [SFFilterComponent<FilteredItem>] {
        components
    }
    
    public static func buildArray(_ components: [[SFFilterComponent<FilteredItem>]]) -> [SFFilterComponent<FilteredItem>] {
        components.flatMap { $0 }
    }
    
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

