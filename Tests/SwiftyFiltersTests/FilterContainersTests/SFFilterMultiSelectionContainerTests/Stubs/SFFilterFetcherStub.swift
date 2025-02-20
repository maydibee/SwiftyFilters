
import SwiftyFilters


final class SFFilterFetcherStub: SFFilterFetcher {
    func fetchFilterItems() async -> [SFFilterCriteriaItemMock] {
        [SFFilterCriteriaItemMock(id: 1), SFFilterCriteriaItemMock(id: 2), SFFilterCriteriaItemMock(id: 3)]
    }
}
