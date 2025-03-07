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


/// A specialized node manager for multi-selection filters.
///
/// This node can be used as a view model for custom UI components. It manages the state of a multi-selection filter
/// and provides a view provider for creating custom views.
///
/// ### Generic Parameters
/// - `FilteredItem`: The type of data being filtered.
///
public class SFFilterMultiSelectionNode<FilteredItem>: SFFilterNode<FilteredItem> {
    
    private let view: ((SFFilterMultiSelectionNode<FilteredItem>) -> any View)

    
    init(component: SFFilterComponent<FilteredItem>, view: @escaping ((SFFilterMultiSelectionNode<FilteredItem>) -> any View)) {
        self.view = view
        super.init(component: component)
    }
    
    override func makeView() -> any View {
        view(self)
    }
}
