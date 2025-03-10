//
//  File.swift
//  
//
//  Created by Michael Skuratau on 27/02/25.
//

import SwiftUI


// MARK: - Multi-selection filter view

/// Default view for multi-selection filter component
///
public struct SFFilterMultiSelectionDefaultView<FilteredItem>: View {
    
    @StateObject var node: SFFilterMultiSelectionNode<FilteredItem>
    
    public init(node: SFFilterMultiSelectionNode<FilteredItem>) {
        _node = StateObject(wrappedValue: node)
    }
    
    public var body: some View {
        Group {
            if node.isLoading {
                ProgressView()
            } else {
                List {
                    ForEach(node.nestedNodes) { child in
                        SFFilterCellView(node: child)
                            .onTapGesture {
                                child.isItemEnabled.toggle()
                            }
                    }
                }
            }
        }
    }
}
