import CommandLineToolCore
import XCTest
import Foundation

class CommandLineToolCoreTests: XCTestCase {
    func testTool() {
        // Redirect stdout
        let template = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("file.XXXXXX")
        // Fill buffer with a C string representing the local file system path.
        var buffer = [Int8](repeating: 0, count: Int(PATH_MAX))
        (template as NSURL).getFileSystemRepresentation(&buffer, maxLength: buffer.count)
        // Create unique file name (and open file):
        let fd = mkstemp(&buffer)
        guard fd != -1 else {
            XCTFail("Error: " + String(describing: strerror(errno)))
            return
        }

        // Create URL from file system string
        let url = URL(fileURLWithFileSystemRepresentation: buffer, isDirectory: false, relativeTo: nil)
        print("Temp file: \(url.path)")
        freopen(buffer, "a+", stdout)

        let tool = CommandLineTool()
        try! tool.run()

        // Flush stdout to file
        fclose(stdout)

        let output = try! String(contentsOf: url, encoding: .utf8)
        XCTAssertEqual(output, "Hello world!\n")
    }

    static var allTests: [(String, (CommandLineToolCoreTests) -> () -> Void)] = [
        ("testTool", testTool),
    ]
}
