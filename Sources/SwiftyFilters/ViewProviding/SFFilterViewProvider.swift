//
//  File.swift
//  
//
//  Created by Софтрэйн on 26/02/25.
//

import SwiftUI



public protocol SFFilterViewProvider<FilteredItem> {
    
    associatedtype FilteredItem
    
    func makeComponentView<Node>(with node: Node) -> any View where Node: SFFilterNode<FilteredItem>
}
