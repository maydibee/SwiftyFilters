//
//  SFFilterDateRangeView.swift
//  ObservationFilters
//
//  Created by Michael Skuratau on 13/02/25.
//

import SwiftUI


// MARK: - Date range filter view

struct SFFilterDateRangeView<FilteredItem>: View {
    
    @StateObject var node: SFFilterRangeNode<FilteredItem, Date>
    
    @Environment(\.startDateString) private var startDateString
    @Environment(\.endDateString) private var endDateString
    @Environment(\.resetString) private var resetString
    
    
    var body: some View {
        List {
            if !node.nestedNodes.isEmpty {
                ForEach(node.nestedNodes) { child in
                    SFFilterCellView(node: child)
                        .onTapGesture {
                            child.isItemEnabled.toggle()
                        }
                }
            }
            
            dateSection(title: startDateString,
                        date: Binding(
                            get: { node.range.lowerBound ?? Date() },
                            set: { newValue in
                                node.range = SFFilterRange(lowerBound: newValue.startOfDay, upperBound: node.range.upperBound)
                            }),
                        range: Date.distantPast...(node.range.upperBound ?? Date.distantFuture),
                        isActive: node.range.lowerBound != nil,
                        onReset: { node.range = SFFilterRange(lowerBound: nil, upperBound: node.range.upperBound) }
            )
            
            dateSection(title: endDateString,
                        date: Binding(
                            get: { node.range.upperBound ?? Date() },
                            set: { newValue in
                                node.range = SFFilterRange(lowerBound: node.range.lowerBound, upperBound: newValue.endOfDay)
                            }),
                        range: (node.range.lowerBound ?? Date.distantPast)...Date.distantFuture,
                        isActive: node.range.upperBound != nil,
                        onReset: { node.range = SFFilterRange(lowerBound: node.range.lowerBound, upperBound: nil) }
            )
        }
        .navigationTitle(node.title)
        .task {
            await self.node.loadFilterIfNeeded()
        }
    }
}


// MARK: - UI Components

private extension SFFilterDateRangeView {
    
    func dateSection(title: String, date: Binding<Date>, range: ClosedRange<Date>, isActive: Bool, onReset: @escaping () -> Void) -> some View {
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
