//
//  SFFilterAllCellView.swift
//  ObservationFilters
//
//  Created by Michael Skuratau on 18/02/25.
//

import SwiftUI


// MARK: - Filters All/Reset action view

struct SFFilterAllCellView<FilteredItem>: View {
    
    @StateObject var node: SFFilterNode<FilteredItem>
    
    @Environment(\.allString) private var allString
    @Environment(\.resetString) private var resetString
    @Environment(\.enabledCheckboxColor) private var enabledCheckboxColor
    
    
    var body: some View {
        HStack {
            Text(" ")
            Spacer()
            Text(node.isItemEnabled ? allString : resetString)
                .fontWeight(.semibold)
                .foregroundStyle(enabledCheckboxColor)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            if node.isItemEnabled {
                node.deselectAll()
            } else {
                node.resetAllFilters()
            }
        }
    }
}
