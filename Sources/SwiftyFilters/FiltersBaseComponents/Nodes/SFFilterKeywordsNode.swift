//
//  SFFilterKeywordsNode.swift
//  ObservationFilters
//
//  Created by Michael Skuratau on 17/02/25.
//

import Foundation


// MARK: - Keywords container filter node (API-RO)

public class SFFilterKeywordsNode<FilteredItem, CriteriaItem: StringProtocol>: SFFilterNode<FilteredItem> {
    
    lazy private var keywordsFilterComponent: SFFilterKeyWordsComponent<FilteredItem, CriteriaItem>? = {
        component as? SFFilterKeyWordsComponent<FilteredItem, CriteriaItem>
    }()
    
    @Published public var keywordsModel: SFFilterKeywordsModel<CriteriaItem> = .init() {
        didSet {
            keywordsFilterComponent?.updateKeywords(keywordsModel)
            self.updateState()
            parent?.updateState()
        }
    }
    
    public override func resetAllFilters() {
        keywordsModel.reset()
        nestedNodes.forEach { node in
            node.resetAllFilters()
        }
    }
}
