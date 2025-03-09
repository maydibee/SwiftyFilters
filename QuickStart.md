# Quick start

Basic usage of SwiftyFilters

## Overview

The basic usage of SwiftyFilters, when custom UI elements for filters are not required, consists of four steps.

#### 1. Define the root filter and implement filter components in the body

```swift

struct AircraftFilter: SFFilter {
    
    let worker: AircraftListWorker
    
    var body: [SFFilterComponent<Aircraft>] {
        
        SFMultiSelectionFilter(title: "Type")
            .fetchItems { await worker.fetchAllTypes() }
            .filter(by: \.type)
        
        SFMultiSelectionFilter(title: "Last exploiter")
            .fetchItems { await self.worker.fetchAllExploiters() }
            .filter(byOptional: \.lastExploater)
            .includeNone(withTitle: "New aircraft")

        SFKeywordsFilter(title: "Remarks")
            .filter(by: \.remarks)
            .includeNone(withTitle: "No remarks")
            
        SFRangeFilter(title: "First flight date")
            .filter(by: \.firstFlightDate)
            .displayIn { node in
                SFFilterDateRangeView(node: node)
            }    
    }
}

```

#### 2. Initialize `SFFiltersCore` and pass the `AircraftFilter` instance to the `content` parameter

```swift
let filter = AircraftFilter(worker: worker)
let filtersCore = SFFiltersCore<Aircraft>(title: "Filters", content: filter)

```

#### 3. Initialize `SFFilterRootView` with the created `filtersCore` and present it where needed

```swift
SFFilterRootView(filtersCore: filtersCore)
```

#### 4. Apply filters on demand

```swift
func applyFilters() {
    self.filteredAircraft = filtersCore.getFilteredData(from: aircraft)
}
```

