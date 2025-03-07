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


// MARK: - Single date filter view

/// Example view for single value filter component
///
public struct SFFilterSingleDateView<FilteredItem>: View {
    
    @StateObject var node: SFFilterSingleValueNode<FilteredItem, Date>
    
    @Environment(\.dateString) private var dateString
    @Environment(\.resetString) private var resetString
    
    
    public var body: some View {
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

