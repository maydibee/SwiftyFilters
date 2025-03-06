# Imperative Approach to Filters in SwiftyFilters

Integrate SwiftyFilters into an iOS app and build filters effortlessly using an imperative approach (Deprecated)

## **Deprecated Notice**

SwiftyFilters previously supported an imperative approach to implementing filters. However, this method is now considered **deprecated** due to the availability of a more **built-in** and **declarative filtering logic** with enhanced features. It is recommended to use the new built-in filtering approach for a more efficient and streamlined experience.

@Metadata {
    @PageImage(
               purpose: icon,
               source: "logoswiftyfilters",
               alt: "Logo"
               )
    @PageKind(article)
    @PageColor(gray)
}

---


## **Filters Implementation**

When implementing filters, there are four key aspects to consider:

1. **What is the input data for the filter?**
2. **What is the criteria item for the filter?**
3. **How should input data be filtered according to the criteria?**
4. **How should the filter component be represented in the UI?**

Let's go through each step in detail.

---

## **1. Filtered Input Data**
The input data refers to the collection of items that need filtering. Typically, this will be an array of objects, such as `Aircraft` models.

```swift
let aircraftList: [Aircraft] = [...]
```

---

## **2. Defining the Criteria**
The filter criteria define how the filtering will be executed. If multiple components influence the filtering process, an array of criteria items will be required.

The `SFFilterFetcher` protocol is responsible for fetching all criteria items used in filtering.

### **Fetcher Implementation**

```swift
import SwiftyFilters

// MARK: - AircraftTypeFilter Fetcher Implementation
class AircraftTypeFilterFetcher: SFFilterFetcher {
    func fetchFilterItems() async -> [AircraftType] {
        try? await Task.sleep(nanoseconds: 200_000_000)
        
        return [
            AircraftType.mockAirbus1,
            AircraftType.mockAirbus2,
            AircraftType.mockBoeing1,
            AircraftType.mockBoeing2,
        ]
    }
}
```

---

## **3. Filtering Logic**
The `SFFilterResolver` protocol is responsible for defining the filtering behavior. The resolver method takes the input data and criteria and returns the filtered result.

### **Resolver Implementation**

```swift
import SwiftyFilters

// MARK: - AircraftTypeFilter Resolver Implementation
class AircraftTypeFilterResolver: SFFilterResolver {
    func filterItems(_ inputItems: [Aircraft], basedOn criteriaItem: [AircraftType], isNoneEnabled: Bool) -> [Aircraft] {
        inputItems.filter { inputItem in
            criteriaItem.contains { $0.id == inputItem.id }
        }
    }
}
```

---

## **4. UI Representation**
The `SFFilterViewProvider` protocol defines how the filter component is presented in the UI.

For multi-selection filters, the framework provides a default view, but a custom view can be implemented if necessary.

### **Filter View Implementation**

```swift
import SwiftUI
import SwiftyFilters

// MARK: - AircraftTypeFilter View
struct AircraftTypeFilterView: View {
    @StateObject var node: SFFilterMultiSelectionNode<Aircraft>
    
    var body: some View {
        Group {
            if node.isLoading {
                ProgressView()
            } else {
                List {
                    ForEach(node.nestedNodes) { child in
                        AircraftTypeFilterCellView(node: child)
                            .onTapGesture { child.isItemEnabled.toggle() }
                    }
                }
            }
        }
    }
}

// MARK: - Filter Cell View
struct AircraftTypeFilterCellView: View {
    @StateObject var node: SFFilterNode<Aircraft>
    
    var body: some View {
        HStack {
            Text(node.title)
                .foregroundStyle(node.isItemEnabled ? .blue : .gray)
            Spacer()
        }
    }
}
```

### **View Provider Implementation**

```swift
class AircraftTypeFilterViewProvider: SFFilterMultiSelectionViewProvider {
    func makeView(with node: SFFilterMultiSelectionNode<Aircraft>) -> any View {
        AircraftTypeFilterView(node: node)
    }
}
```

---

## **Creating the Filter Component**

Using the `SFFilterComponentsFactory`, we create the filter component by passing the fetcher, resolver, and view provider.

```swift
let aircraftTypeFilterComponent = SFFilterComponentsFactory.createMultiSelectionComponent(
    title: "Type",
    resolver: AircraftTypeFilterResolver(),
    fetcher: AircraftTypeFilterFetcher(),
    viewProvider: AircraftTypeFilterViewProvider()
)
```

### **Fixing Compilation Errors**

Ensure that the `AircraftType` model conforms to the necessary protocols:

```swift
extension AircraftType: Identifiable, SFFiltersTitleable {
    var title: String { self.name }
}
```

---

## **Managing the Filters**

The `SFFiltersCore` class manages the filters tree and notifies the UI of updates.

```swift
self.filtersCore = SFFiltersCore<Aircraft>(title: "Filters") {
    aircraftTypeFilterComponent
}
```

### **Filters View Implementation**

```swift
struct AircraftListFiltersView: View {
    @StateObject var filtersCore: SFFiltersCore<Aircraft>
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            Button("Reset") { filtersCore.resetFilters() }
            SFFilterRootView(filtersCore: filtersCore)
        }
    }
}
```

### **Triggering Filtering**

```swift
AircraftListFiltersView(filtersCore: viewModel.filtersCore)
    .onDisappear {
        viewModel.applyFilters()
    }
```

---

## **Advanced Features: Grouped Filters**

Filters can be grouped using `SFGroupedComponent`, allowing nested filters.

```swift
self.filtersCore = SFFiltersCore<Aircraft>(title: "Filters") {
    aircraftTypeFilterComponent
    
    SFGroupedComponent(title: "Dates") {
        aircraftFirstFlightDateFilterComponent
        aircraftManufactureDateFilterComponent
    }
}
```

---

## **Conclusion**

While the imperative approach in SwiftyFilters provides flexibility, it is **now outdated**. The built-in filtering logic offers a more efficient and maintainable way to implement filters. It is **strongly recommended** to migrate to the new approach for improved performance and usability.

