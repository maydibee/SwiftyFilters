//
//  SFFilterComponentView.swift
//  ObservationFilters
//
//  Created by Michael Skuratau on 17/02/25.
//

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
                            if let dateRangeNode = child as? SFFilterRangeNode<FilteredItem, Date> {
                                NavigationLink(destination: SFFilterDateRangeView(node: dateRangeNode)) {
                                    SFFilterCellView(node: child)
                                }
                            } else if let singleDateNode = child as? SFFilterSingleValueNode<FilteredItem, Date> {
                                NavigationLink(destination: SFFilterSingleDateView(node: singleDateNode)) {
                                    SFFilterCellView(node: child)
                                }
                            } else if let keywordsNode = child as? SFFilterKeywordsNode<FilteredItem, String> {
                                NavigationLink(destination: SFFilterKeywordsView(node: keywordsNode)) {
                                    SFFilterCellView(node: child)
                                }
                            } else {
                                
                                SFFilterCellView(node: child)
                                    .onTapGesture {
                                        child.isItemEnabled.toggle()
                                    }
                            }
                            
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
