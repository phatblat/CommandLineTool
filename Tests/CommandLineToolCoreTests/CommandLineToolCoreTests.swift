import CommandLineToolCore
import Basic
import XCTest
import Foundation

class CommandLineToolCoreTests: XCTestCase {
    func testTool() {
        let tempFile = try! TemporaryFile() // from SwiftPM.Basic
        print("Temp file: \(tempFile)")

        // Redirect stdout to temp file
        freopen(tempFile.path.asString.cString(using: .utf8), "a+", stdout)

        let tool = CommandLineTool()
        try! tool.run()

        // Flush stdout to file
        fclose(stdout)

        let output = try! String(contentsOfFile: tempFile.path.asString, encoding: .utf8)
        XCTAssertEqual(output, "Hello world!\n")
    }

    static var allTests: [(String, (CommandLineToolCoreTests) -> () -> Void)] = [
        ("testTool", testTool),
    ]
}
