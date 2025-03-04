//
//  File.swift
//  
//
//  Created by Michael Skuratau on 27/02/25.
//

import Foundation
import SwiftUI


// TODO: add documentation

public class SFFilterKeywordsDefaultViewProvider<FilteredItem>: SFFilterKeywordsViewProvider {
    
    public init() {}
    
    
    public func makeView(with node: SFFilterKeywordsNode<FilteredItem, String>) -> any View {
        SFFilterKeywordsDefaultView(node: node)
    }
   
}
