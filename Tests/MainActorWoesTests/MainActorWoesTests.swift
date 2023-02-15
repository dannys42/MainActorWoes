import XCTest
@testable import MainActorWoes

final class MainActorWoesTests: XCTestCase {
    
    
    @MainActor
    func testExample01() throws {
        let sut = Example01()
        XCTAssertNotEqual(sut.userInterfaceIdiom, .unspecified)
    }
    
    
    // This will deadlock because the test is running on the MainThread, preventing the MainActor task from executing.
    func testExample03() throws {
        let sut = Example03()
        
        XCTAssertNotEqual(sut.userInterfaceIdiom, .unspecified)
    }
}
