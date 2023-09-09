import XCTest
@testable import AuthencationPreview

final class AuthencationPreviewTests: XCTestCase {
  func testExamle() throws {
    XCTAssertEqual(echo(), "Hello, World!!")
  }

  func echo() -> String {
    "Hello, World!!"
  }
}
