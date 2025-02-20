
import SwiftyFilters


final class SFFilterResolverSingleValueStub: SFFilterResolver {
    func filterItems(
        _ items: [SFFilterFilteredItemMock],
        basedOn criteria: Int,
        isNoneEnabled: Bool
    ) -> [SFFilterFilteredItemMock] {
        items.filter { $0.id == criteria }
    }
}

