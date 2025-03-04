//
//  BooleanOptionFilterView.swift
//  SwiftyFilters-Example-iOS
//
//  Created by Michael Skuratau on 04/03/25.
//

import SwiftyFilters
import SwiftUI


// MARK: - Bool value filter view

struct BooleanOptionFilterView<FilteredItem>: View {

    @StateObject var node: SFFilterSingleValueNode<FilteredItem, Bool>
    
    struct Option {
        let value: Bool
        let title: String
    }
    
    private let options = [Option(value: true, title: "Yes"),
                           Option(value: false, title: "No")]
    

    var body: some View {
        List {
            if node.value != nil {
                Button(action: resetSelection) {
                    HStack {
                        Text("Reset")
                            .foregroundColor(.red)
                        Spacer()
                    }
                }
            }

            ForEach(options, id: \.value) { option in
                HStack {
                    Text(option.title)
                        .foregroundColor(node.value == option.value ? .blue : .primary)
                    Spacer()
                    if node.value == option.value {
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    node.value = option.value
                }
            }
        }
        .navigationTitle(node.title)
        .animation(.easeInOut, value: node.value)
    }
    
    private func resetSelection() {
        node.value = nil
    }
}
