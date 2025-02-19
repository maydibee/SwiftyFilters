//
//  SFFiltersBuilder.swift
//  ObservationFilters
//
//  Created by Michael Skuratau on 10/02/25.
//

import Foundation


// MARK: - Filters hierarchy builder

@resultBuilder
public struct SFFiltersBuilder<FilteredItem> {
    
    public static func buildBlock(_ components: [any SFFilterComponent<FilteredItem>]...) -> [any SFFilterComponent<FilteredItem>] {
        components.flatMap { $0 }
    }
    
    public static func buildExpression(_ expression: any SFFilterComponent<FilteredItem>) -> [any SFFilterComponent<FilteredItem>] {
        [expression]
    }
    
    public static func buildExpression(_ expression: [any SFFilterComponent<FilteredItem>]) -> [any SFFilterComponent<FilteredItem>] {
        expression
    }
    
    public static func buildOptional(_ components: [any SFFilterComponent<FilteredItem>]?) -> [any SFFilterComponent<FilteredItem>] {
        components ?? []
    }
    
    public static func buildEither(first components: [any SFFilterComponent<FilteredItem>]) -> [any SFFilterComponent<FilteredItem>] {
        components
    }
    
    public static func buildEither(second components: [any SFFilterComponent<FilteredItem>]) -> [any SFFilterComponent<FilteredItem>] {
        components
    }
    
    public static func buildArray(_ components: [[any SFFilterComponent<FilteredItem>]]) -> [any SFFilterComponent<FilteredItem>] {
        components.flatMap { $0 }
    }
    
    public static func buildExpression(_ expression: SFGroupedComponent<FilteredItem>) -> [any SFFilterComponent<FilteredItem>] {
        let components = expression.content()
        return [self.createGroupedItem(title: expression.title, from: components)]
    }
}

private extension SFFiltersBuilder {
    
    static func createGroupedItem(title: String, from components: [any SFFilterComponent<FilteredItem>]) -> SFFilterMasterComponent<FilteredItem> {
        SFFilterMasterComponent(title: title, nestedFilterItems: components)
    }
}

