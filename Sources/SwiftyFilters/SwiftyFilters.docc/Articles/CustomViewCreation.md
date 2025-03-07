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

Swifty filters supply us with default views for filter components like ``SFMultiSelectionFilter`` and ``SFKeywordsFilter``. However SwiftyFilters is a flexible from the prospective of UI as well since it allows you to use your own UI implememtations for filter components in case if default implementations are not following your requirements or while using filters such as ``SFRangeFilter`` or ``SFSingleValueFilter`` without default views. By the way SwiftyFilters provides us with example views for these filters that can be copy to your project and customised according to your requirements or even can be used as a reference for your custom UI for filter component.


In this article we will consider how to create a custom filter views by example of creating views for ``SFRangeFilter`` and ``SFMultiSelectionFilter``. For other filter types the strategy will be almost the same.

### Creating custom view for range filter

Let's assume that we need a view that will be responsible for representing dates range filter. 
View implememntation and its controlls may be different across implementations of views for certain filter, but the key thing is that your view need to embed corresponding type of node manager into itself and operates with it like with view model. For each type of filter designed specific node manager, but all nodes has almost the same role namely:

- Providing component title specified when defining filter
- Managing state of filter component, like filter or loading activity
- Providing model of critaria items for updates
- Providing the ability for bulk oberations like filter reseting 

Let's cut to the chase and implement custom date range view and review how to operate with view node:

Here is how the view may looks like:

```swift


// Code here


```

What's happening here?

1) We have embedded ``SFFilterRangeNode`` into the view to operate with it as with view model that have a type of the second generic type as Date, because our aim is to create a dates range filter. 
2) We are using ``SFFilterRangeNode/range``  model from the node to obtain dates range lower and upper bounds and modify or reset it as well
3) Title is beight used for representing navigation title
4) We have creted the separate button responsible for filter resetting by call ``SFFilterRangeNode/resetAllFilters()`` method.
5) We are using ``SFFilterNode/loadFilterIfNeeded()`` to load all nested nodes for the filter. In case of ``SFFilterRangeNode`` after loading nested nodes will contain only None option if it's being included by ``SFRangeFilter/includeNone(withTitle:)`` method. So for representing it we are using a ForEach view and pass child node to implemented `FilterCellView` that is representing the title of child node and the state(is selected or not). 
6) You might also noticed that we triggers child selection state by tapping on `FilterCellView` in order to enable or disable criteria item (None option in our case).

