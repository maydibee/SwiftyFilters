
import SwiftyFilters


final class SFFilterResolverRangeStub: SFFilterResolver {
    func filterItems(
        _ items: [SFFilterFilteredItemMock],
        basedOn criteria: SFFilterRange<Int>,
        isNoneEnabled: Bool
    ) -> [SFFilterFilteredItemMock] {
        items.filter { criteria.contains($0.id) }
    }
}
