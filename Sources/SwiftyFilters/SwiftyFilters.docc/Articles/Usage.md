# Getting started with SwiftyFilters

Integrate SwiftyFilters into an iOS app and build filters effortlessly using a declarative approach


@Metadata {
    @PageImage(
               purpose: icon,
               source: "logoswiftyfilters.png",
               alt: "Logo"
               )
    @PageKind(article)
}

## Overview

In this article, we'll walk through how to create filters step-by-step, using a declarative approach that feels right at home in the SwiftUI ecosystem. Ready to feel the magic? Let's dive in! 

---

## The Four Key Questions to Answer Before Building Filters

Before diving into code, it's essential to answer four foundational questions to guide your filter implementation:

#### 1. What is the filtered input data?
This is the data you want to filter—typically an array of objects (e.g., a list of aircraft).

#### 2. What is the criteria for filtering?
Define the criteria items that will be used to filter the input data (e.g., aircraft types, dates, or keywords).

#### 3. How should the input data be filtered?
Specify the property of the input item that the filter should use for matching. For example, filter aircraft by their `type` property.

#### 4. How should the filter component be represented in the UI?
Decide how the filter will be displayed to the user. Will it be a multi-selection list, a date range picker, or a keyword search?

By answering these questions, you'll have a clear roadmap for implementing your filters.

---

## Planning Your Filter: Answering the Key Questions

Let's walk through an example of building a filter for a list of aircraft. We'll filter the aircraft by their **type** using a multi-selection filter.

The final project can be found in the repository within the **SwiftyFilters-Example-iOS** target.

### 1. What is the filtered input data?
In our example, it's an array of `Aircraft` objects:

```swift
struct Aircraft: Identifiable {
    var id: UUID
    var type: AircraftType
    var remarks: String
    // ... other properties
}
```

### 2. What is the criteria for filtering?
For our **aircraft type filter**, it's an array of `AircraftType`. We'll fetch these types from a worker class:

```swift
protocol AircraftListWorker {
    func fetchAllTypes() async -> [AircraftType]
}

class AircraftListWorkerStub: AircraftListWorker {
    func fetchAllTypes() async -> [AircraftType] {
        try? await Task.sleep(nanoseconds: 200_000_000) // Simulate network delay
        return [.mockAirbus1, .mockAirbus2, .mockBoeing1, .mockBoeing2]
    }
}
```

#### Key Requirement:
Your **criteria type (`AircraftType`)** must conform to `SFFiltersTitleable` and `Equatable`:

```swift
import SwiftyFilters

// MARK: - SFFiltersTitleable implementation
extension AircraftType: SFFiltersTitleable {
    var title: String { self.name }
}

// MARK: - Equatable implementation
extension AircraftType: Equatable {
    static func == (lhs: AircraftType, rhs: AircraftType) -> Bool {
        lhs.id == rhs.id
    }
}
```

### 3. How should the input data be filtered?
Here, we filter aircraft by their **type** property.

### 4. How is the filter displayed?

For the UI, we'll create a custom multi-selection view. SwiftyFilters provides default views for multi-selection and keywords-based filters, but we'll build a custom one for demonstration:

```swift
import SwiftyFilters
import SwiftUI

// MARK: - Multi-selection filter custom view

struct MultiSelectionFilterView: View {
    
    @StateObject var node: SFFilterMultiSelectionNode<Aircraft>
    
    var body: some View {
        Group {
            if node.isLoading {
                ProgressView()
            } else {
                List {
                    Group {
                        MultiSelectionFilterActionsCell(node: node)
                        ForEach(node.nestedNodes) { child in
                            MultiSelectionFilterCell(node: child)
                                .onTapGesture {
                                    child.isItemEnabled.toggle()
                                }
                        }
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                }
                .listStyle(PlainListStyle())
            }
        }
        .animation(.easeIn(duration: 0.1), value: node.isItemEnabled)
    }
}
```

#### Key Notes About Node
A Node (like `SFFilterMultiSelectionNode`) acts as a state manager for your filter:
- Tracks selections, loading states, and criteria.
- Provides `nestedNodes` for each criteria item.
- Use `@StateObject` to preserve state across updates.

For advanced usage, see the SwiftyFilters Documentation or review the following article: <doc:CustomViewCreation>

### Building the Filter Component  
Perfect! We're all set to start creating our filter component. This is where the real magic of SwiftyFilters happens ✨—building filters declaratively, just like you build SwiftUI views. With SwiftyFilters, you define what you want to filter, and the framework takes care of the how. Let's dive into the process step by step.

#### 1. Define the Root Filter
Start by creating a struct conforming to `SFFilter`. Just like SwiftUI's `View` protocol, this requires a `body` property where we define our filter hierarchy:

```swift
import SwiftyFilters

// - MARK: AircraftFilter

struct AircraftFilter: SFFilter {
    var body: [SFFilterComponent<Aircraft>] {
        // Filters will be added here
    }
}
```

#### 2. Add a Multi-Selection Filter
Let's implement our aircraft type filter. We'll use `SFMultiSelectionFilter`, specifying:
- The filtered type (`Aircraft`).
- The criteria type (`AircraftType`).
- A title for the UI.

```swift
import SwiftyFilters

// - MARK: AircraftFilter

struct AircraftFilter: SFFilter {

    let worker: AircraftListWorker
    
    var body: [SFFilterComponent<Aircraft>] {
        SFMultiSelectionFilter<Aircraft, AircraftType>(title: "Type")
            .fetchItems { await worker.fetchAllTypes() }
            .filter(by: \ .type)
            .displayIn { node in
                MultiSelectionFilterView(node: node)
            }
    }
}
```

##### What's happening here?
- `.fetchItems`: Fetches the criteria items (aircraft types).
- `.filter(by: \ .type)`: Filters aircraft by their `type` property.
- `.displayIn`: Uses our custom view for the filter.

#### 3. Expand with More Filters
Let's add additional filters to demonstrate SwiftyFilters' flexibility:

```swift
import SwiftyFilters

// - MARK: AircraftFilter

struct AircraftFilter: SFFilter {
    
    let worker: AircraftListWorker
    
    var body: [SFFilterComponent<Aircraft>] {
        // MARK: - Aircraft Type Filter
        SFMultiSelectionFilter<Aircraft, AircraftType>(title: "Type")
            .fetchItems { await worker.fetchAllTypes() }
            .filter(by: \ .type)
            .displayIn { MultiSelectionFilterView(node: $0) }
        
        // MARK: - Last Exploiter Filter (with default UI)
        SFMultiSelectionFilter<Aircraft, AircraftExploiter>(title: "Last Exploiter")
            .fetchItems { await worker.fetchAllExploiters() }
            .filter(byOptional: \ .lastExploater)
            .includeNone(withTitle: "New Aircraft")
        
        // MARK: - Remarks Keyword Filter
        SFKeywordsFilter(title: "Remarks")
            .filter(by: \ .remarks)
            .includeNone(withTitle: "No Remarks")
        
        // MARK: - Dates Section (Grouped)
        SFGroupedComponent(title: "Dates") {
            SFRangeFilter(title: "First Flight Date")
                .filter(by: \ .firstFlightDate)
                .displayIn { SFFilterDateRangeView(node: $0) }
            
            // MARK: - Age Section (Grouped)
            SFGroupedComponent(title: "Age") {
                SFRangeFilter(title: "Manufacture Date")
                    .filter(by: \ .manufactureDate)
                    .displayIn { SFFilterDateRangeView(node: $0) }
                
                SFSingleValueFilter<Aircraft, Bool>(title: "Is New?")
                    .filter(by: \ .isNew)
                    .displayIn { BooleanOptionFilterView(node: $0) }
            }
        }
    }
}
```

#### 4. Refactor for Readability
Just like SwiftUI views, you can decompose large filters into smaller components. Let's extract the dates section into the separate `AircraftDatesFilter` conforming to `SFFilter`:

```swift
import SwiftyFilters

// - MARK: AircraftDatesFilter sub-filter

struct AircraftDatesFilter: SFFilter {

    var body: [SFFilterComponent<Aircraft>] {
        SFGroupedComponent(title: "Dates") {
            SFRangeFilter(title: "First Flight Date")
                .filter(by: \ .firstFlightDate)
                .displayIn { SFFilterDateRangeView(node: $0) }
            
            SFGroupedComponent(title: "Age") {
                SFRangeFilter(title: "Manufacture Date")
                    .filter(by: \ .manufactureDate)
                    .displayIn { SFFilterDateRangeView(node: $0) }
                
                SFSingleValueFilter<Aircraft, Bool>(title: "Is New?")
                    .filter(by: \ .isNew)
                    .displayIn { BooleanOptionFilterView(node: $0) }
            }
        }
    }
}
```

Then, use it in your root filter:

```swift
import SwiftyFilters

// - MARK: AircraftFilter

struct AircraftFilter: SFFilter {
    let worker: AircraftListWorker
    
    var body: [SFFilterComponent<Aircraft>] {
        SFMultiSelectionFilter<Aircraft, AircraftType>(title: "Type") { ... }
        SFMultiSelectionFilter<Aircraft, AircraftExploiter>(title: "Last Exploiter") { ... }
        SFKeywordsFilter(title: "Remarks") { ... }
        
        // Reusable dates section
        AircraftDatesFilter()
    }
}
```

## Managing State and Integrating with SwiftUI

With our filter component built, it's time to bring everything together. Let's manage the filter state and integrate it into a SwiftUI view - just like you'd manage state for a typical SwiftUI component.

### 1. Create the Filter State Manager

We'll use `SFFiltersCore` to manage the filter hierarchy and state. Think of this as the equivalent of `ObservableObject` for your filters:

```swift
import SwiftUI
import SwiftyFilters

// MARK: - AircraftListViewModel 

class AircraftListViewModel: ObservableObject {
    
    private var aircraft: [Aircraft] = []
    private let worker: AircraftListWorker
    
    @Published var filteredAircraft: [Aircraft] = []
    @Published var isFiltersViewPresented = false
    
    let filtersCore: SFFiltersCore<Aircraft>
    
    
    init(worker: AircraftListWorker) {
        self.worker = worker
        let filter = AircraftFilter(worker: worker)
        self.filtersCore = SFFiltersCore<Aircraft>(title: "Filters", content: filter)
    }
    
    func loadAircraft() async {
        self.aircraft = await worker.fetchAllAircraft()
        await MainActor.run {
            self.filteredAircraft = self.aircraft
        }
    }
    
    func applyFilters() {
        self.filteredAircraft = filtersCore.getFilteredData(from: aircraft)
    }
}
```

#### Key Points:
- `SFFiltersCore` manages the entire filter tree's state.
- `getFilteredData(from:)` applies all active filters to your raw data.
- The ViewModel bridges your data and the filter logic.

### 2. Build the Filters View

Create a SwiftUI view to display the filter interface. This is where `SFFilterRootView` shines – it automatically renders your filter hierarchy:

```swift
import SwiftUI
import SwiftyFilters

// MARK: - AircraftListFiltersView

struct AircraftListFiltersView: View {
    @StateObject var filtersCore: SFFiltersCore<Aircraft>
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            // Custom toolbar
            HStack {
                Button("Reset") { filtersCore.resetFilters() }
                Spacer()
                Button("OK") { dismiss() }
            }
            .padding()
            .background(Color.blue.opacity(0.8))
            
            // The magic happens here
            SFFilterRootView(filtersCore: filtersCore)
        }
    }
}
```

#### What's Special Here?
- `SFFilterRootView` automatically displays your filter components.
- The **Reset** button clears all filter selections.
- The **OK** button dismisses the view while preserving state.

### 3. Connect to Your Main View

Finally, present the filters and apply them when dismissed:

```swift
import SwiftUI

// MARK: - AircraftListView

struct AircraftListView: View {
    
    @StateObject var viewModel: AircraftListViewModel
    
    
    var body: some View {
        NavigationView {
            // List view is being hidden for the sake of readability
            .sheet(isPresented: $viewModel.isFiltersViewPresented) {
                AircraftListFiltersView(filtersCore: viewModel.filtersCore)
                    .onDisappear {
                        viewModel.applyFilters()
                    }
            }
        }
    }
}
```

The `.onDisappear` modifier ensures filters are applied automatically when users close the filters view. For more control, you could move `applyFilters()` to a **Done** button action instead.

### Final Result

You've now built:
- A declarative filter component hierarchy
- A state manager for filter rules
- A reusable filters view
- Seamless SwiftUI integration

The entire system works like a well-oiled machine:
**Users select filters → `SFFiltersCore` tracks changes → Filtered results update on demand according to filters tree state.**

### Final Thoughts

`SwiftyFilters` transforms filter creation from a tedious task into a streamlined, SwiftUI-like experience. By focusing on *what* to filter rather than *how*, you can build sophisticated filter systems in minutes — not hours.

