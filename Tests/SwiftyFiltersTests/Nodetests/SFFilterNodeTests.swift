
import XCTest
import Combine
@testable import SwiftyFilters


final class SFFilterNodeTests: XCTestCase {
    
    // MARK: - Properties
    
    private var component: SFFilterComponentStub<Int>!
    private var parentNode: SFFilterNode<Int>!
    private var node: SFFilterNode<Int>!
    
    // MARK: - Test Setup
    
    override func setUp() {
        super.setUp()
        component = SFFilterComponentStub(title: "Test Component", isItemEnabled: true, isComposite: true)
        node = SFFilterNode(component: component)
    }
    
    override func tearDown() {
        component = nil
        parentNode = nil
        node = nil
        super.tearDown()
    }
    
    // MARK: - Initialization Tests
    
    func testInitialization_ShouldSetCorrectProperties() {
        // Assert
        XCTAssertEqual(node.title, "Test Component")
        XCTAssertTrue(node.isComposite)
        XCTAssertTrue(node.isItemEnabled)
        XCTAssertIdentical(node.component, component)
    }
    
    // MARK: - State Management Tests
    
    func testIsItemEnabled_WhenSet_ShouldUpdateComponentAndParent() {
        // Arrange
        let parentComponent = SFFilterComponentStub<Int>(title: "Parent Component", isItemEnabled: true, isComposite: true)
        parentNode = SFFilterNode(component: parentComponent)
        node.parent = parentNode
        
        // Act
        node.isItemEnabled = false
        
        // Assert
        XCTAssertFalse(node.isItemEnabled)
        XCTAssertFalse(component.isItemEnabled)
        XCTAssertFalse(parentNode.isItemEnabled)
    }
    
    // MARK: - Reset All Filters Tests
    
    func testResetAllFilters_ShouldEnableAllNodes() {
        // Arrange
        let childComponent = SFFilterComponentStub<Int>(title: "Child Component", isItemEnabled: false, isComposite: false)
        let childNode = SFFilterNode(component: childComponent)
        node.nestedNodes = [childNode]
        
        // Act
        node.resetAllFilters()
        
        // Assert
        XCTAssertTrue(node.isItemEnabled)
        XCTAssertTrue(childNode.isItemEnabled)
    }
    
    // MARK: - Deselect All Tests
    
    func testDeselectAll_ShouldDisableAllNodes() {
        // Arrange
        let childComponent = SFFilterComponentStub<Int>(title: "Child Component", isItemEnabled: true, isComposite: false)
        let childNode = SFFilterNode(component: childComponent)
        node.nestedNodes = [childNode]
        
        // Act
        node.deselectAll()
        
        // Assert
        XCTAssertFalse(node.isItemEnabled)
        XCTAssertFalse(childNode.isItemEnabled)
    }
    
    // MARK: - Filtered Data Tests
    
    func testGetFilteredData_ShouldApplyFiltering() {
        // Arrange
        let inputItems = [1, 2, 3, 4, 5]
        component.getFilteredItemsResult = [2, 3, 4]
        
        // Act
        let result = node.getFilteredData(from: inputItems)
        
        // Assert
        XCTAssertEqual(result, [2, 3, 4])
    }
    
    func testGetFilteredData_WithNestedNodes_ShouldApplyNestedFiltering() {
        // Arrange
        let inputItems = [1, 2, 3, 4, 5]
        let childComponent = SFFilterComponentStub<Int>(title: "Child Component", isItemEnabled: true, isComposite: false)
        childComponent.getFilteredItemsResult = [3, 4]
        let childNode = SFFilterNode(component: childComponent)
        node.nestedNodes = [childNode]
        component.getFilteredItemsResult = [2, 3, 4]
        
        // Act
        let result = node.getFilteredData(from: inputItems)
        
        // Assert
        XCTAssertEqual(result, [3, 4])
    }
    
    // MARK: - Load Nested Items Tests
    
    func testLoadFilterIfNeeded_ShouldLoadNestedItems() async {
        // Arrange
        let nestedComponent = SFFilterComponentStub<Int>(title: "Nested Component", isItemEnabled: true, isComposite: false)
        component.loadNestedItemsResult = [nestedComponent]
        
        // Act
        await node.loadFilterIfNeeded()
        
        // Assert
        XCTAssertEqual(node.nestedNodes.count, 1)
        XCTAssertEqual(node.nestedNodes.first?.title, "Nested Component")
        XCTAssertFalse(node.isLoading)
    }
    
    func testLoadFilterIfNeeded_WhenAlreadyLoaded_ShouldNotReload() async {
        // Arrange
        let nestedComponent = SFFilterComponentStub<Int>(title: "Nested Component", isItemEnabled: true, isComposite: false)
        node.nestedNodes = [SFFilterNode(component: nestedComponent)]
        
        // Act
        await node.loadFilterIfNeeded()
        
        // Assert
        XCTAssertEqual(node.nestedNodes.count, 1)
    }
    
    // MARK: - Update State Tests
    
    func testUpdateState_ShouldSyncWithComponent() {
        // Arrange
        component.isItemEnabled = false
        
        // Act
        node.updateState()
        
        // Assert
        XCTAssertFalse(node.isItemEnabled)
    }
}

