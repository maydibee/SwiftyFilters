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


// MARK: - Filters component view

struct SFFilterComponentView<FilteredItem>: View {
    
    @StateObject var node: SFFilterNode<FilteredItem>
    
    
    var body: some View {
        Group {
            if node.isLoading {
                ProgressView()
            } else {
                List {
                    if node.component.isAllActionIncluded {
                        SFFilterAllCellView(node: node)
                    }
                    ForEach(node.nestedNodes) { child in
                        if child.isComposite {
                            NavigationLink(destination: SFFilterComponentView(node: child)) {
                                SFFilterCellView(node: child)
                            }
                        } else {
                            
                            NavigationLink {
                                AnyView(child.makeView())
                            } label: {
                                SFFilterCellView(node: child)
                            }

                            
//                            if let dateRangeNode = child as? SFFilterRangeNode<FilteredItem, Date> {
//                                NavigationLink(destination: SFFilterDateRangeView(node: dateRangeNode)) {
//                                    SFFilterCellView(node: child)
//                                }
//                            } else if let singleDateNode = child as? SFFilterSingleValueNode<FilteredItem, Date> {
//                                NavigationLink(destination: SFFilterSingleDateView(node: singleDateNode)) {
//                                    SFFilterCellView(node: child)
//                                }
//                            } else if let keywordsNode = child as? SFFilterKeywordsNode<FilteredItem, String> {
//                                NavigationLink(destination: SFFilterKeywordsView(node: keywordsNode)) {
//                                    SFFilterCellView(node: child)
//                                }
//                            } else {
//                                
//                                SFFilterCellView(node: child)
//                                    .onTapGesture {
//                                        child.isItemEnabled.toggle()
//                                    }
//                            }
                            
                        }
                    }
                }
                .navigationTitle(node.title)
            }
        }
        .task {
            await self.node.loadFilterIfNeeded()
        }
        
    }
}
