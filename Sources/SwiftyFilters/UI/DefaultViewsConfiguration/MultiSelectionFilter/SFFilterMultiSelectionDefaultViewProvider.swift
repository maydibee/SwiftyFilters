//
//  File.swift
//  
//
//  Created by Софтрэйн on 27/02/25.
//

import Foundation
import SwiftUI


// TODO: add documentation

public class SFFilterMultiSelectionDefaultViewProvider<FilteredItem>: SFFilterMultiSelectionViewProvider {
    
    public init() {}
    
    
    public func makeView(with node: SFFilterMultiSelectionNode<FilteredItem>) -> any View {
        SFFilterMultiSelectionDefaultView(node: node)
    }
   
}
