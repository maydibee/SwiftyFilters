
import SwiftyFilters


struct SFFilterCriteriaItemMock: Identifiable, SFFiltersTitleable {
    let id: Int
    var title: String { "Item \(id)" }
}
