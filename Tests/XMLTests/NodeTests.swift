import XCTest
import XML
import SnapshotTesting

final class NodeTests: XCTestCase {

    func testNodeWithNothing() throws {
        let document = Document {
            Node("node")
        }
        assertSnapshot(of: document.encoded(), as: .data)
    }

    func testNodeWithAttribute() throws {
        let document = Document {
            Node("node", attributes: ["key": "value"])
        }
        assertSnapshot(of: document.encoded(), as: .data)
    }

    func testNodeWithAttributes() throws {
        let document = Document {
            Node("node", attributes: ["key2": "value2", "key1": "value1"])
        }
        assertSnapshot(of: document.encoded(options: .init(shouldSortAttributeKeys: true)), as: .data)
    }

    func testNodeWithChild() throws {
        let document = Document {
            Node("parent") {
                Node("child")
            }
        }
        assertSnapshot(of: document.encoded(), as: .data)
    }

    func testNodeWithChildren() throws {
        let document = Document {
            Node("parent") {
                Node("child1")
                Node("child2")
                Node("child3")
            }
        }
        assertSnapshot(of: document.encoded(), as: .data)
    }

    func testNodeWithText() throws {
        let document = Document {
            Node("node", content: "text")
        }
        assertSnapshot(of: document.encoded(), as: .data)
    }

    func testNodeResultBuilder() throws {
        let document = Document {
            Node("parent") {
                Node("child")

                if "a" == "a" {
                    Node("child0")
                }

                if "a" == "b" {
                    Node("child0")
                }

                if "a" == "a" {
                    Node("child1")
                    Node("child2")
                }

                if "a" == "a" {
                    Node("childA")
                } else {
                    Node("childB")
                }

                if "a" == "b" {
                    Node("childA")
                } else {
                    Node("childB")
                }

                for index in 0..<10 {
                    Node("child\(index)")
                }

                if #available(macOS 10.0, *) {
                    Node("childg")
                }
            }
        }
        assertSnapshot(of: document.encoded(), as: .data)
    }
}
