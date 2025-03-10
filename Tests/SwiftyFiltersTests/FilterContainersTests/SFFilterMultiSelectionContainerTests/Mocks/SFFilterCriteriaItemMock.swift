
import SwiftyFilters


struct SFFilterCriteriaItemMock: Equatable, SFFiltersTitleable {
    let id: Int
    var title: String { "Item \(id)" }
    
    static func == (lhs: SFFilterCriteriaItemMock, rhs: SFFilterCriteriaItemMock) -> Bool {
        lhs.id == rhs.id
    }
}
