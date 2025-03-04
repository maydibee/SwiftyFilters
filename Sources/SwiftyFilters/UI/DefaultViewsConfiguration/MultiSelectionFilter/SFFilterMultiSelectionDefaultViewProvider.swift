//
//  File.swift
//  
//
//  Created by Michael Skuratau on 27/02/25.
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
