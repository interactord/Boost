import XCTest
@testable import Platform

final class PlatformTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Platform().text, "Hello, World!")
    }
}
