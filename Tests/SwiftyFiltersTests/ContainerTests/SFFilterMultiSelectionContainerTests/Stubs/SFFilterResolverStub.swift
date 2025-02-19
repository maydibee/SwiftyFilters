
import SwiftyFilters


final class SFFilterResolverStub: SFFilterResolver {
    func filterItems(_ items: [SFFilterFilteredItemMock], basedOn criteria: [SFFilterCriteriaItemMock], isNoneEnabled: Bool) -> [SFFilterFilteredItemMock] {
        items.filter { $0.id != 1 }
    }
}
