import Foundation


struct Aircraft {
    
    var id: UUID
    var type: AircraftType
    var remarks: String
    var capacity: Int
    var lastExploater: AircraftExploiter?
    
    var firstFlightDate: Date?
    var manufactureDate: Date
    
    var isNew: Bool {
        lastExploater == nil
    }
}
