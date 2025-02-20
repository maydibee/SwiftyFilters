
import SwiftyFilters


final class SFFilterResolverStub: SFFilterResolver {
    func filterItems(_ inputItems: [SFFilterFilteredItemMock], basedOn criteriaItem: [SFFilterCriteriaItemMock], isNoneEnabled: Bool) -> [SFFilterFilteredItemMock] {
        inputItems.filter { $0.id != 1 }
    }
}
