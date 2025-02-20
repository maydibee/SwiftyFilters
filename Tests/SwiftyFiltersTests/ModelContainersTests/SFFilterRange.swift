
import XCTest
@testable import SwiftyFilters


final class SFFilterRangeTests: XCTestCase {
    
    // MARK: - Test Cases
    
    func testContains_BothBoundsSet_ValueWithinRange() {
        // Arrange
        let range = SFFilterRange(lowerBound: 5, upperBound: 10)
        
        // Act & Assert
        XCTAssertTrue(range.contains(7))
        XCTAssertTrue(range.contains(5))
        XCTAssertTrue(range.contains(10))
    }
    
    func testContains_BothBoundsSet_ValueOutsideRange() {
        // Arrange
        let range = SFFilterRange(lowerBound: 5, upperBound: 10)
        
        // Act & Assert
        XCTAssertFalse(range.contains(3))
        XCTAssertFalse(range.contains(12))
    }
    
    func testContains_LowerBoundOnly_ValueWithinRange() {
        // Arrange
        let range = SFFilterRange(lowerBound: 5, upperBound: nil)
        
        // Act & Assert
        XCTAssertTrue(range.contains(7))
        XCTAssertTrue(range.contains(5))
    }
    
    func testContains_LowerBoundOnly_ValueOutsideRange() {
        // Arrange
        let range = SFFilterRange(lowerBound: 5, upperBound: nil)
        
        // Act & Assert
        XCTAssertFalse(range.contains(3)) // Значение ниже нижней границы
    }
    
    func testContains_UpperBoundOnly_ValueWithinRange() {
        // Arrange
        let range = SFFilterRange(lowerBound: nil, upperBound: 10)
        
        // Act & Assert
        XCTAssertTrue(range.contains(7))
        XCTAssertTrue(range.contains(10))
    }
    
    func testContains_UpperBoundOnly_ValueOutsideRange() {
        // Arrange
        let range = SFFilterRange(lowerBound: nil, upperBound: 10)
        
        // Act & Assert
        XCTAssertFalse(range.contains(12))
    }
    
    func testContains_NoBounds_AlwaysReturnsTrue() {
        // Arrange
        let range = SFFilterRange<Int>(lowerBound: nil, upperBound: nil)
        
        // Act & Assert
        XCTAssertTrue(range.contains(0))
        XCTAssertTrue(range.contains(100))
    }
    
    func testContains_EdgeCases() {
        // Arrange
        let range = SFFilterRange(lowerBound: 5, upperBound: 10)
        
        // Act & Assert
        XCTAssertTrue(range.contains(5))
        XCTAssertTrue(range.contains(10))
        XCTAssertFalse(range.contains(4))
        XCTAssertFalse(range.contains(11))
    }
    
    func testContains_DoubleType() {
        // Arrange
        let range = SFFilterRange(lowerBound: 5.5, upperBound: 10.5)
        
        // Act & Assert
        XCTAssertTrue(range.contains(7.5))
        XCTAssertFalse(range.contains(5.4))
        XCTAssertFalse(range.contains(10.6))
    }
    
    func testContains_DateType() {
        // Arrange
        let lowerBound = Date(timeIntervalSince1970: 0)
        let upperBound = Date(timeIntervalSince1970: 1000)
        let range = SFFilterRange(lowerBound: lowerBound, upperBound: upperBound)
        
        let dateInside = Date(timeIntervalSince1970: 500)
        let dateBelow = Date(timeIntervalSince1970: -100)
        let dateAbove = Date(timeIntervalSince1970: 2000)
        
        // Act & Assert
        XCTAssertTrue(range.contains(dateInside))
        XCTAssertFalse(range.contains(dateBelow))
        XCTAssertFalse(range.contains(dateAbove))
    }
}
