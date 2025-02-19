//
//  SFFilterComponentsFactory.swift
//  ObservationFilters
//
//  Created by Michael Skuratau on 17/02/25.
//

import Foundation


// MARK: - Filter's base components abstract factory

public class SFFilterComponentsFactory {
    
    public static func createMultiSelectionComponent<FilteredItem, CriteriaItem: Identifiable & SFFiltersTitleable>(title: String,
                                                                                                                    resolver: any SFFilterResolver<FilteredItem, [CriteriaItem]>,
                                                                                                                    fetcher: any SFFilterFetcher<CriteriaItem>,
                                                                                                                    isNoneIncluded: Bool = false,
                                                                                                                    noneItemTitle: String) -> any SFFilterComponent<FilteredItem> {
        let container = SFFilterMultiSelectionContainer(resolver: resolver, fetcher: fetcher, isNoneIncluded: isNoneIncluded)
        let component = SFFilterMultiSelectionComponent(title: title, noneItemTitle: noneItemTitle, filter: container)
        return component
    }
    
    public static func createRangeComponent<FilteredItem, CriteriaItem: Comparable>(title: String,
                                                                                    resolver: any SFFilterResolver<FilteredItem, SFFilterRange<CriteriaItem>>,
                                                                                    isNoneIncluded: Bool = false,
                                                                                    noneItemTitle: String) -> any SFFilterComponent<FilteredItem> {
        let container = SFFilterRangeContainer(resolver: resolver, isNoneIncluded: isNoneIncluded)
        let component = SFFilterRangeComponent(title: title, noneItemTitle: noneItemTitle, filter: container)
        return component
    }
    
    public static func createKeywordsComponent<FilteredItem, CriteriaItem: StringProtocol>(title: String,
                                                                                           resolver: any SFFilterResolver<FilteredItem, SFFilterKeywordsModel<CriteriaItem>>,
                                                                                           isNoneIncluded: Bool = false,
                                                                                           noneItemTitle: String) -> any SFFilterComponent<FilteredItem> {
        let container = SFFilterKeyWordsContainer(resolver: resolver, isNoneIncluded: isNoneIncluded)
        let component = SFFilterKeyWordsComponent(title: title, noneItemTitle: noneItemTitle, filter: container)
        return component
    }
    
    public static func createSingleValueComponent<FilteredItem, CriteriaItem: Equatable>(title: String,
                                                                                         resolver: any SFFilterResolver<FilteredItem, CriteriaItem>,
                                                                                         isNoneIncluded: Bool = false,
                                                                                         noneItemTitle: String) -> any SFFilterComponent<FilteredItem> {
        let container = SFFilterSingleValueContainer(resolver: resolver, isNoneIncluded: isNoneIncluded)
        let component = SFFilterSingleValueComponent(title: title, noneItemTitle: noneItemTitle, filter: container)
        return component
    }
}
