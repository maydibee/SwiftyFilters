<p align="center">
  <img src="SwiftyFiltersLogo.png" alt="SwiftyFilters Banner">
</p> <!-- Закрываем тег <p> для изображения -->

<p align="center">
  <a href="https://github.com/maydibee/SwiftyFilters/actions/workflows/run-tests.yml"><img src="https://github.com/maydibee/SwiftyFilters/actions/workflows/run-tests.yml/badge.svg" alt="CI"></a>
  <a href="https://swift.org/"><img src="https://img.shields.io/badge/Swift-5.7%2B-orange?logo=swift" alt="Swift Version"></a>
  <a href="https://swift.org/"><img src="https://img.shields.io/badge/SwiftUI-seamless-purple?logo=swift" alt="SwiftUI seamless compatibility"></a>
  <a href="https://github.com/maydibee/SwiftyFilters/blob/main/LICENSE"><img src="https://img.shields.io/badge/License-MIT-blue.svg" alt="License"></a>
  <a href="https://swift.org/package-manager/"><img src="https://img.shields.io/badge/SPM-Supported-brightgreen.svg" alt="SPM Supported"></a>
  <a href="https://developer.apple.com/ios/"><img src="https://img.shields.io/badge/Platform-iOS 15+-lightgrey?logo=apple" alt="Platform iOS 15+"></a>
</p>

<h2 align="left">Build High-Performance Filter Trees Declaratively</h2>
---

**Never has creating complex filters in iOS apps been so effortless.** Magic is here ✨ 

**SwiftyFilters** is a lightweight, pure-Swift framework that lets you create complex filter systems using a DSL-like syntax - think SwiftUI, but for filtering.

**The secret?** A SwiftUI-inspired syntax that transforms tedious filtering logic into clean, expressive code. Whether you're filtering aircraft by type, products by price, or events by date, SwiftyFilters lets you focus on what you want to achieve, while it handles the how.

Built with performance in mind, SwiftyFilters uses lazy-loading at every level to ensure your app stays fast and responsive. It only loads data and allocates resources when they’re actually needed.

## 🚀 Features

- **Declarative API**: Define filters using a SwiftUI-like syntax.
- **Nested Filters**: Create complex filter hierarchies with ease.
- **Lazy Loading**: Resources are loaded only when needed.
- **SwiftUI Integration**: Designed to work seamlessly with SwiftUI.
- **Customizable**: Use default UI components or build your own.

---

## 📦 Installation

### Swift Package Manager

1. In Xcode, open your project and navigate to **File → Add Packages...**.
2. Paste the repository URL: 
https://github.com/maydibee/SwiftyFilters.git
3. Select the version you want to use (or leave as "Up to Next Major").
4. Click **Add Package**.

### Manual Setup

Add SwiftyFilters as a dependency in your `Package.swift`:
```swift
dependencies: [
 .package(url: "https://github.com/maydibee/SwiftyFilters.git", from: "1.0.0")
]
```

### Quick start
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

## 📝 Documentation

Read the full documentation here:  
👉 [SwiftyFilters Documentation](https://maydibee.github.io/SwiftyFilters/documentation/swiftyfilters/)


👉 [Usage](https://maydibee.github.io/SwiftyFilters/documentation/swiftyfilters/usage)

