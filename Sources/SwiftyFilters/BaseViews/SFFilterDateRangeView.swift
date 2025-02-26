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


// MARK: - Date range filter view

public struct SFFilterDateRangeView<FilteredItem>: View {
    
    @StateObject var node: SFFilterRangeNode<FilteredItem, Date>
    
    @Environment(\.startDateString) private var startDateString
    @Environment(\.endDateString) private var endDateString
    @Environment(\.resetString) private var resetString
    @Environment(\.colorScheme) private var colorScheme
    
    
    public init(node: SFFilterRangeNode<FilteredItem, Date>) {
        _node = StateObject(wrappedValue: node)
    }
    
    public var body: some View {
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
                .foregroundStyle(isActive ? .blue : colorScheme == .dark ? .white : .black)
            Spacer()
            Button(resetString, action: onReset)
                .disabled(!isActive)
        }
        .padding(.horizontal, 5)
    }
    
    func datePickerView(date: Binding<Date>, range: ClosedRange<Date>) -> some View {
        DatePicker("", selection: date, in: range, displayedComponents: .date)
            .datePickerStyle(.wheel)
            .labelsHidden()
    }
}
