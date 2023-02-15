import XCTest
@testable import MainActorWoes

final class MainActorWoesTests: XCTestCase {
    
    @MainActor
    func testExample01() {
        let sut = Example01()
        XCTAssertNotEqual(sut.userInterfaceIdiom, .unspecified)
    }
    
    
    // This will deadlock because the test is running on the main thread, preventing the MainActor task from executing.
    func testExample03a() {
        let sut = Example03()
        
        XCTAssertNotEqual(sut.userInterfaceIdiom, .unspecified)
    }
    
    
    // This avoids the deadlock, but makes testing more complicated.  In addition, there are no compile-time safegards to prevent Example03() from initizling on the main thread.
    func testExample03b() {
        let expectation = XCTestExpectation()
        
        Thread {
            let sut = Example03()
            
            XCTAssertNotEqual(sut.userInterfaceIdiom, .unspecified)

            expectation.fulfill()
        }.start()
        
        
        wait(for: [expectation], timeout: 2)
    }
}
