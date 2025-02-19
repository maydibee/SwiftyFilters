//
//  SFFilterRangeNode.swift
//  ObservationFilters
//
//  Created by Michael Skuratau on 17/02/25.
//

import Foundation


// MARK: - Range filter node (API-RO)

public class SFFilterRangeNode<FilteredItem, CriteriaItem: Comparable>: SFFilterNode<FilteredItem> {
    
    lazy private var rangeFilterComponent: SFFilterRangeComponent<FilteredItem, CriteriaItem>? = {
        component as? SFFilterRangeComponent<FilteredItem, CriteriaItem>
    }()

    @Published public var range: SFFilterRange<CriteriaItem> = .init(lowerBound: nil, upperBound: nil) {
        didSet {
            rangeFilterComponent?.updateRange(range)
            self.updateState()
            parent?.updateState()
        }
    }
    
    override public func resetAllFilters() {
        range = .init(lowerBound: nil, upperBound: nil)
        nestedNodes.forEach { node in
            node.resetAllFilters()
        }
    }
}

