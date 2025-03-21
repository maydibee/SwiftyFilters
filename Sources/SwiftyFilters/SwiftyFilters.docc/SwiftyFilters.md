# ``SwiftyFilters``

A lightweight framework designed to simplify the creation of complex filter systems in iOS apps 


@Metadata {
    @Available(iOS, introduced: "15.0")
    @PageImage(
               purpose: icon,
               source: "logoswiftyfilters",
               alt: "Logo"
               )
}


## Overview

Building filters in SwiftUI just got easier. **SwiftyFilters** is a lightweight, pure-Swift framework that lets you create complex filter systems using a DSL-like syntax - think SwiftUI, but for filtering. Magic is here ✨

**The secret?** A SwiftUI-inspired syntax that transforms tedious filtering logic into clean, expressive code. Whether you're filtering aircraft by type, products by price, or events by date, SwiftyFilters lets you focus on what you want to achieve, while it handles the how.

### Key Benefits:
- **Declarative API**: Define filters using a SwiftUI-like syntax.
- **Nested Filters**: Create complex filter hierarchies with ease.
- **Lazy Loading**: Resources are loaded only when needed.
- **SwiftUI Integration**: Designed to work seamlessly with SwiftUI.
- **Customizable**: Use default UI components or build your own.

## Topics

### Essentials

- <doc:Usage>
- <doc:CustomViewCreation>
- ``SFFilter``
- ``SFFiltersCore``
- ``SFFilterRootView``
- ``SFGroupedComponent``

### Filter types

- ``SFMultiSelectionFilter``
- ``SFKeywordsFilter``
- ``SFRangeFilter``
- ``SFSingleValueFilter``

### Node state managers

- ``SFFilterMultiSelectionNode``
- ``SFFilterKeywordsNode``
- ``SFFilterRangeNode``
- ``SFFilterSingleValueNode``
- ``SFFilterNode``

### Filter models

- ``SFFilterKeywordsModel``
- ``SFFilterRange``

### Default views

- ``SFFilterMultiSelectionDefaultView``
- ``SFFilterKeywordsDefaultView``

### Example views

- ``SFFilterDateRangeView``
- ``SFFilterSingleDateView``


### Imperative approach (**Deprecated**)

- <doc:Imperative>
- ``SFFilterFetcher``
- ``SFFilterResolver``
- ``SFFilterMultiSelectionViewProvider``
- ``SFFilterKeywordsViewProvider``
- ``SFFilterRangeViewProvider``
- ``SFFilterSingleValueViewProvider``
- ``SFFilterComponentsFactory``
- ``SFFilterComponent``


