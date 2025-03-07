//
//  File.swift
//  
//
//  Created by Michael Skuratau on 27/02/25.
//

import Foundation
import SwiftUI


/// Default view provider for keyword-based filter component
///
public class SFFilterKeywordsDefaultViewProvider<FilteredItem>: SFFilterKeywordsViewProvider {
    
    public init() {}
    
    
    public func makeView(with node: SFFilterKeywordsNode<FilteredItem, String>) -> any View {
        SFFilterKeywordsDefaultView(node: node)
    }
   
}
