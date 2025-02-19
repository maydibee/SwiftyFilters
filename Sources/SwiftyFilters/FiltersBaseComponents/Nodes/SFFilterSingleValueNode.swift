//
//  SFFilterSingleValueNode.swift
//  ObservationFilters
//
//  Created by Michael Skuratau on 17/02/25.
//

import Foundation


// MARK: - Single value filter node (API-RO)

public class SFFilterSingleValueNode<FilteredItem, CriteriaItem: Equatable>: SFFilterNode<FilteredItem> {
    
    lazy private var singleValueFilterComponent: SFFilterSingleValueComponent<FilteredItem, CriteriaItem>? = {
        component as? SFFilterSingleValueComponent<FilteredItem, CriteriaItem>
    }()
    
    @Published public var value: CriteriaItem? {
        didSet {
            singleValueFilterComponent?.updateValue(value)
            self.updateState()
            parent?.updateState()
        }
    }

    public override func resetAllFilters() {
        value = nil
        nestedNodes.forEach { node in
            node.resetAllFilters()
        }
    }
}
