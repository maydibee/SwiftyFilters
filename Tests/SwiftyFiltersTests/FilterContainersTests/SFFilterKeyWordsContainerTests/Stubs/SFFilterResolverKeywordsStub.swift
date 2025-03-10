
import SwiftyFilters


final class SFFilterResolverKeywordsStub: SFFilterResolver {
    
    func filterItems (_ inputItems: [SFFilterFilteredItemKeywordsMock], basedOn criteriaItem: SFFilterKeywordsModel<String>, isNoneEnabled: Bool) -> [SFFilterFilteredItemKeywordsMock] {
        return []
    }
}
