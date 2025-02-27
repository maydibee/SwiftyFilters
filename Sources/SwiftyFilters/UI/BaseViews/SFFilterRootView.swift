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


/// A view that displays the root of the filter hierarchy.
///
/// This view is responsible for rendering the entire filter tree and managing its appearance and behavior.
///
/// ### Example
/// ```swift
/// SFFilterRootView(filtersCore: filtersCore)
/// ```
///
public struct SFFilterRootView<FilteredItem>: View {
    
    /// The core filter object that manages the filter hierarchy.
    @StateObject public var filtersCore: SFFiltersCore<FilteredItem>
    @Environment(\.titleDisplayMode) var titleDisplayMode
    

    /// Initializes a new `SFFilterRootView`.
    ///
    /// - Parameter filtersCore: The core filter object.
    ///
    public init(filtersCore: SFFiltersCore<FilteredItem>) {
        _filtersCore = StateObject(wrappedValue: filtersCore)
    }
    
    public var body: some View {
        NavigationView {
            if let rootNode = filtersCore.rootNode {
                SFFilterComponentView(node: rootNode)
                    .navigationBarTitleDisplayMode(titleDisplayMode)
            } else {
                ProgressView()
            }
        }
        .onAppear {
            if filtersCore.rootNode == nil {
                filtersCore.compose()
            }
        }
    }
}
