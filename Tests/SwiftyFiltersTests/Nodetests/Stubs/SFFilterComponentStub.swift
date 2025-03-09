
@testable import SwiftyFilters


final class SFFilterComponentStub<FilteredItem>: SFFilterComponent<FilteredItem> {
    
    var loadNestedItemsResult: [SFFilterComponent<FilteredItem>] = []
    var getFilteredItemsResult: [FilteredItem] = []
    
    override func loadNestedItems() async -> [SFFilterComponent<FilteredItem>] {
        loadNestedItemsResult
    }
    
    override func getFilteredItems(for items: [FilteredItem]) -> [FilteredItem] {
        getFilteredItemsResult
    }
    
    override func updateState() {
        self.isItemEnabled = false
    }
    
    override func createRelatedNode() -> SFFilterNode<FilteredItem> {
        SFFilterNode(component: self)
    }
}
