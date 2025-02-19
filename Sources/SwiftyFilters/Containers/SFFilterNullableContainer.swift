//
//  SFFilterNullableContainer.swift
//  ObservationFilters
//
//  Created by Michael Skuratau on 17/02/25.
//

import Foundation


// MARK: - Abstraction for containers that can tackle none-containing elements (API-RO)

public protocol SFFilterNullableContainer: AnyObject {
    var isNoneEnabled: Bool { get set }
}
