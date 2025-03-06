# Filter types

Description of the existing filter types privided by SwiftyFilters 

@Metadata {
    @PageImage(
               purpose: icon,
               source: "logoswiftyfilters.png",
               alt: "Logo"
               )
    @PageKind(article)
}

## Overview

SwiftyFilters supplies us with several types of filter components elaborated for a specific purpose for each. And each filter component can be embedded as a separate component into filters tree with it's specific configuration responsible for filtering an input object by specified parameter.




### Multi-selection filter

``SFMultiSelectionFilter``


#### Description

This filter type can be used if your main aim is to filter an input items according to a set of several homogenious items, that can be selected by a client via UI. Consider using a list of airctaft that need to be filtered based on selected aircraft types by user
This filter provides the following methods:

1. The ``SFMultiSelectionFilter/fetchItems(_:)`` method is created in order to fill a filter component with all criteria items that can be used for selection by user. By implementing the method you need to provide a way to get an array of criteria items in asynchronious way 

2. The ``SFMultiSelectionFilter/filter(by:)`` can be used if your demand is to filter an input items by non-optional property of concrete input item. An implementation of the method will compare the set of selected criteria items with a value of provided property and resolve is the property value is included in criteria items array.

3. The ``SFMultiSelectionFilter/filter(byOptional:)`` works the same way like previous but is created for an optional properies and if property value is nil - an element will be included in result only on case if None oprion is enabled. 
- Tip: By default None option is disabled and if you are using ``SFMultiSelectionFilter/filter(byOptional:)`` method and None option isn't even included - all elemnets with nil value of the specified propery will be weeded out by filter

4. The ``SFMultiSelectionFilter/filter(byArray:)`` methods purpose is the same like for the last two filter methods but it allows to filter input items by property represenetd as an array of types matches the type of criteria items. It checks if an array of a specified propery value contains at least one element from selected criteria items. If yes - an input item will be included in result, otherwise not
- Tip: By default None option is disabled and if you are using ``SFMultiSelectionFilter/filter(byArray:)`` method and None option isn't even included - all elemnets with an empty array value of the specified propery will be weeded out by filter

5. The ``SFMultiSelectionFilter/filter(_:)`` method should be used only on case if no any method for filtering above isn't suitable for your demands and you need some specific filtering behavior. This method allows you to define custom filtering behaviour for filtering input items (the first input parameter in closure) based on selected criteria items (the second input parameter in closure) and on the bool value indicates is None option enabled (the third input parameter in closure). You need to keep in mind that None option is disabled by default if it isn't included. Otherwise, you have included None option - None option will be enabled by default until it will be changed manually, for example by UI

6. The ``SFMultiSelectionFilter/includeNone(withTitle:)`` method can be used to include None option in filter component with specified title, for example localized "None"
7. The ``SFMultiSelectionFilter/displayIn(_:)`` method is created to specify the UI where created filter component need to be displayed. The view with embadded ``SFFilterMultiSelectionNode`` provided by input closure parameter need to be returned in the method closure
- Tip: SwiftyFilters will use default view ``SFFilterMultiSelectionDefaultView`` for multi-selection filter component if ``SFMultiSelectionFilter/displayIn(_:)`` isn't being called. Hence the method ``SFMultiSelectionFilter/displayIn(_:)`` need to be called only if case if the default view isn't follow your demands. In this case you can implement a custom view or copy/rename provided by the framework and mogify it according to thw wishes.

