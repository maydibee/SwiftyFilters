//
//  File.swift
//  
//
//  Created by Софтрэйн on 26/02/25.
//

import SwiftUI



public protocol SFFilterViewProvider<FilteredItem> {
    
    associatedtype FilteredItem
    associatedtype Node
    
    func makeComponentView(with node: Node) -> any View
}


import SwiftUI

public protocol SFFilterMultiSelectionViewProvider<FilteredItem> {
    
    associatedtype FilteredItem
    
    func makeView(with node: SFFilterMultiSelectionNode<FilteredItem>) -> any View
}


public protocol SFFilterKeywordsViewProvider<FilteredItem, CriteriaItem> where CriteriaItem: StringProtocol {
    
    associatedtype FilteredItem
    associatedtype CriteriaItem
    
    func makeView(with node: SFFilterKeywordsNode<FilteredItem, CriteriaItem>) -> any View
}


public protocol SFFilterRangeViewProvider<FilteredItem, CriteriaItem> where CriteriaItem: Comparable {
    
    associatedtype FilteredItem
    associatedtype CriteriaItem
    
    func makeView(with node: SFFilterRangeNode<FilteredItem, CriteriaItem>) -> any View
}


public protocol SFFilterSingleValueViewProvider<FilteredItem, CriteriaItem> where CriteriaItem: Equatable {
    
    associatedtype FilteredItem
    associatedtype CriteriaItem
    
    func makeView(with node: SFFilterSingleValueNode<FilteredItem, CriteriaItem>) -> any View
}





