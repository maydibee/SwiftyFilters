# Creation of custom views

Learn how to create custom views for filter components


@Metadata {
    @PageImage(
               purpose: icon,
               source: "logoswiftyfilters.png",
               alt: "Logo"
               )
    @PageKind(article)
}

## Overview

SwiftyFilters provides default views for filter components like ``SFMultiSelectionFilter`` and ``SFKeywordsFilter``. However, SwiftyFilters is also flexible in terms of UI, allowing you to implement your own custom UI for filter components if the default implementations do not meet your requirements. This is particularly useful when working with filters such as ``SFRangeFilter`` or ``SFSingleValueFilter``, which do not come with default views. 

Additionally, SwiftyFilters offers example views for these filters, which you can copy into your project, customize as needed, or use as references for creating your own custom UI for filter components.

In this article, we will explore how to create custom filter views using ``SFRangeFilter`` and ``SFMultiSelectionFilter`` as examples. The general approach will be similar for other filter types.

### Creating a custom view for a range filter

Let's assume we need a view responsible for representing a date range filter. 

The implementation and controls of the view may vary depending on specific needs, but the key aspect is that your view should embed the corresponding type of node manager and operate with it as a view model. Each filter type has a dedicated node manager, but all nodes share a common purpose:

- Providing the component title specified when defining the filter
- Managing the state of the filter component, such as filter activity or loading state
- Providing a model of criteria items for updates
- Enabling bulk operations like resetting the filter

Now, let's dive into the implementation of a custom date range view and see how to interact with the view node:

Here’s how the view might look:

```swift
import SwiftyFilters


struct FilterDateRangeView<FilteredItem>: View {
    
    @StateObject var node: SFFilterRangeNode<FilteredItem, Date>
    
    @Environment(\.colorScheme) private var colorScheme

    
    var body: some View {
        
        Button {
            node.resetAllFilters()
        } label: {
            Text("Reset")
        }

        List {
            if !node.nestedNodes.isEmpty {
                ForEach(node.nestedNodes) { child in
                    FilterCellView(node: child)
                        .onTapGesture {
                            child.isItemEnabled.toggle()
                        }
                }
            }
            
            dateSection(title: "Start date",
                        date: Binding(
                            get: { node.range.lowerBound ?? Date() },
                            set: { newValue in
                                node.range = SFFilterRange(lowerBound: newValue.startOfDay, upperBound: node.range.upperBound)
                            }),
                        range: Date.distantPast...(node.range.upperBound ?? Date.distantFuture),
                        isActive: node.range.lowerBound != nil,
                        onReset: { node.range = SFFilterRange(lowerBound: nil, upperBound: node.range.upperBound) }
            )
            
            dateSection(title: "Finish date",
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
    }
}


// MARK: - UI Components

private extension FilterDateRangeView {
    
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
            Button("Reset", action: onReset)
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


public struct FilterCellView<FilteredItem>: View {
    
    @StateObject var node: SFFilterNode<FilteredItem>
    
    public var body: some View {
        HStack {
            Text(node.title)
            Spacer()
            Group {
                if node.isItemEnabled {
                    Image(systemName: "checkmark.circle.fill")
                } else {
                    Image(systemName: "circle")
                }
            }
            .foregroundColor(.blue)
        }
        .contentShape(Rectangle())
    }
}
```

### What happens in this implementation?

1) We embed ``SFFilterRangeNode`` into the view and use it as a view model. Since we are creating a date range filter, we specify `Date` as the type for the second generic parameter.
2) We use the ``SFFilterRangeNode/range`` model from the node to obtain and modify the lower and upper bounds of the date range, as well as to reset it if needed.
3) The title is used to represent the navigation title.
4) We create a separate button responsible for resetting the filter by calling the ``SFFilterRangeNode/resetAllFilters()`` method.
5) All nested nodes of the node will be loaded automatically when our custom view appears on the screen. In the case of ``SFFilterRangeNode``, after loading, the nested nodes will contain only the "None" option if it has been included via the ``SFRangeFilter/includeNone(withTitle:)`` method. To display this, we use a `ForEach` view, passing the child node to an implemented `FilterCellView`, which represents the title and selection state of the child node.
6) Additionally, we trigger changes in the selection state by tapping on `FilterCellView`, allowing the user to enable or disable a criteria item (e.g., the "None" option in this case).
- Tip: You can combine a custom views with the views provided by the framework, for example in our case we could use ``SFFilterCellView`` instead of creating `FilterCellView` if it meet your requirements.

All nested nodes of the node will be loaded automatically when our custom view appears on the screen.

### Using the custom view

After the view is ready, we can use it to display the range filter component by calling the ``SFRangeFilter/displayIn(_:)`` method:

```swift

// MARK: Manufacture date filter

SFRangeFilter(title: "Manufacture date")
    .filter(by: \.manufactureDate)
    .displayIn { node in
        FilterDateRangeView(node: node)
    }

```

### Creating a custom view for a multi-selection filter

Creating a custom view for a multi-selection filter is almost the same as for a range filter, but it uses a different type of node manager: ``SFFilterMultiSelectionNode``, which is designed for multi-selection filters.

The main difference lies in the nested nodes. While a range filter node contains only a "None" option (if included), a multi-selection filter node contains child nodes corresponding to each criteria item, plus the "None" option if included.

In a multi-selection filter component, the main node provides nested nodes for each criteria item. These nodes can be used to display the list of selectable options in the multi-selection view and to manage user interactions. To represent each criteria item, we can use either the `FilterCellView` implemented above or the default ``SFFilterCellView`` provided by the framework.

The creation of a custom view for a multi-selection filter is briefly covered in the following article: <doc:Usage>
