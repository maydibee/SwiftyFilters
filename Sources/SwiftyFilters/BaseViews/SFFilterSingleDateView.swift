//
//  SFFilterSingleDateView.swift
//  ObservationFilters
//
//  Created by Michael Skuratau on 14/02/25.
//

import SwiftUI


// MARK: - Single date filter view

struct SFFilterSingleDateView<FilteredItem>: View {
    
    @StateObject var node: SFFilterSingleValueNode<FilteredItem, Date>
    
    @Environment(\.dateString) private var dateString
    @Environment(\.resetString) private var resetString
    
    
    var body: some View {
        List {
            Group {
                if !node.nestedNodes.isEmpty {
                    ForEach(node.nestedNodes) { child in
                        SFFilterCellView(node: child)
                            .onTapGesture {
                                child.isItemEnabled.toggle()
                            }
                    }
                }
                dateSection(title: dateString,
                            date: Binding(
                                get: { node.value ?? Date() },
                                set: { newValue in
                                    node.value = newValue
                                }),
                            isActive: node.value != nil,
                            onReset: { node.value = nil }
                )
            }
        }
        .navigationTitle(node.title)
        .task {
            await self.node.loadFilterIfNeeded()
        }
    }
}


// MARK: - UI Components

private extension SFFilterSingleDateView {

    func dateSection(title: String, date: Binding<Date>, range: ClosedRange<Date> = Date.distantPast...Date.distantFuture, isActive: Bool, onReset: @escaping () -> Void) -> some View {
        VStack(spacing: 8) {
            headerView(title: title, isActive: isActive, onReset: onReset)
            datePickerView(date: date, range: range)
        }
    }
    
    func headerView(title: String, isActive: Bool, onReset: @escaping () -> Void) -> some View {
        HStack {
            Text(title)
                .bold()
                .foregroundStyle(isActive ? .blue : .black)
            Spacer()
            Button(resetString, action: onReset)
                .disabled(!isActive)
        }
        .padding(.horizontal)
    }
    
    func datePickerView(date: Binding<Date>, range: ClosedRange<Date>) -> some View {
        DatePicker("", selection: date, in: range, displayedComponents: .date)
            .datePickerStyle(.wheel)
            .labelsHidden()
    }
}

