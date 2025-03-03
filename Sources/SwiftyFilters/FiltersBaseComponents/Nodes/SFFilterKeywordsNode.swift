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
import SwiftUI


/// A specialized node for keyword-based filters.
///
/// This node can be used as a view model for custom UI components. It manages the state of a keywords filter
/// and provides a `keywordsModel` for UI updates.
///
public class SFFilterKeywordsNode<FilteredItem, CriteriaItem: StringProtocol>: SFFilterNode<FilteredItem> {
    
    private let view: ((SFFilterKeywordsNode<FilteredItem, CriteriaItem>) -> any View)
    
    lazy private var keywordsFilterComponent: SFFilterKeyWordsComponent<FilteredItem, CriteriaItem>? = {
        component as? SFFilterKeyWordsComponent<FilteredItem, CriteriaItem>
    }()
    
    /// A model representing the keywords for UI updates.
    ///
    /// When set, it updates the associated filter component and propagates the change to the parent node.
    ///
    @Published public var keywordsModel: SFFilterKeywordsModel<CriteriaItem> = .init() {
        didSet {
            keywordsFilterComponent?.updateKeywords(keywordsModel)
            self.updateState()
            parent?.updateState()
        }
    }
    
    
    init(component: SFFilterComponent<FilteredItem>, view: @escaping ((SFFilterKeywordsNode<FilteredItem, CriteriaItem>) -> any View)) {
        self.view = view
        super.init(component: component)
    }
    
    /// Resets the keywords model and all nested nodes.
    ///
    public override func resetAllFilters() {
        keywordsModel.reset()
        nestedNodes.forEach { node in
            node.resetAllFilters()
        }
    }
    
    override func makeView() -> any View {
        view(self)
    }
}
