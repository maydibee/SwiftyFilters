//
//  SFFilterCellView.swift
//  ObservationFilters
//
//  Created by Michael Skuratau on 17/02/25.
//

import SwiftUI


// MARK: - Filters cell view

struct SFFilterCellView<FilteredItem>: View {
    
    @StateObject var node: SFFilterNode<FilteredItem>
    
    @Environment(\.enabledCheckboxImage) private var enabledCheckboxImage
    @Environment(\.disabledCheckboxImage) private var disabledCheckboxImage
    @Environment(\.enabledCheckboxColor) private var enabledCheckboxColor
    @Environment(\.disabledCheckboxColor) private var disabledCheckboxColor
    
    
    var body: some View {
        HStack {
            Text(node.title)
            Spacer()
            Group {
                if node.isItemEnabled {
                    enabledCheckboxImage
                } else {
                    disabledCheckboxImage
                }
            }
            .foregroundColor(node.isItemEnabled ? enabledCheckboxColor : disabledCheckboxColor)
        }
        .contentShape(Rectangle())
    }
}
