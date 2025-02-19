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


// MARK: - Master filter component (API-RO)

public class SFFilterMasterComponent<FilteredItem>: SFFilterComponent<FilteredItem> {
    
    private let nestedFilterComponents: [SFFilterComponent<FilteredItem>]
    
    
    public init(title: String, nestedFilterItems: [SFFilterComponent<FilteredItem>]) {
        self.nestedFilterComponents = nestedFilterItems
        super.init(title: title,
                   isItemEnabled: !nestedFilterComponents.contains(where: { !$0.isItemEnabled }),
                   isComposite: true)
    }
    
    public override func loadNestedItems() async -> [SFFilterComponent<FilteredItem>] {
        return self.nestedFilterComponents
    }
    
    public override func updateState() {
        self.isItemEnabled = !nestedFilterComponents.contains(where: { !$0.isItemEnabled })
    }
    
    public override func createRelatedNode() -> SFFilterNode<FilteredItem> {
        SFFilterNode<FilteredItem>(component: self)
    }
}
