//
//  SFFiltersCore.swift
//  ObservationFilters
//
//  Created by Michael Skuratau on 10/02/25.
//

import Foundation


public class SFFiltersCore<FilteredItem>: ObservableObject {

    public let title: String
    
    @Published public var rootNode: SFFilterNode<FilteredItem>?
    public var onFiltesUpdated: (() -> Void)?
    
    private var filters: [any SFFilterComponent<FilteredItem>]
    
    
    public init(title: String, @SFFiltersBuilder<FilteredItem> builder: () -> [any SFFilterComponent<FilteredItem>]) {
        self.title = title
        self.filters = builder()
    }
    
    func compose() {
        let filterComponents: [any SFFilterComponent<FilteredItem>] = filters
        let master = SFFilterMasterComponent(title: self.title, nestedFilterItems: filterComponents)
        self.rootNode = SFFilterNode(component: master)
    }
    
    public func getFilteredData(from items: [FilteredItem]) -> [FilteredItem] {
        guard let rootNode else { return items }
        return rootNode.getFilteredData(from: items)
    }
}
