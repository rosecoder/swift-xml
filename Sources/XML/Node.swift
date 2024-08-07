import Foundation

/// A node usable with a XML document.
public struct Node {

    /// Name of the node. Must be non-empty.
    public var name: String

    /// A set of attributes. Optional.
    public var attributes: [String: String]

    /// Content of the node. Optional.
    public var content: Content

    /// Initializes a new node.
    /// - Parameters:
    ///   - name: Name of the node. Must be non-empty.
    ///   - attributes: A set of attributes. Optional.
    ///   - content: Content of the node. Optional.
    ///
    /// Example creating a simple node:
    /// ```
    /// Node("root")
    /// ```
    ///
    /// Example creating a complex node with children:
    /// ```
    /// Node("named", attributes: ["key": "value"], content: "text")
    /// ```
    public init(
        _ name: String,
        attributes: [String: String] = [:],
        content: Content = .none
    ) {
        self.name = name
        self.attributes = attributes
        self.content = content
    }

    /// Initializes a new node.
    /// - Parameters:
    ///   - name: Name of the node. Must be non-empty.
    ///   - attributes: A set of attributes. Optional.
    ///   - content: Content of the node. Optional.
    ///
    /// Example creating a simple node:
    /// ```
    /// Node("root")
    /// ```
    ///
    /// Example creating a complex node with children:
    /// ```
    /// Node("named", attributes: ["key": "value"]) {
    ///     Node("child1")
    ///     Node("child2")
    /// }
    /// ```
    public init(
        _ name: String,
        attributes: [String: String] = [:],
        @NodeBuilder _ content: () -> [Node]
    ) {
        self.name = name
        self.attributes = attributes
        self.content = .children(content())
    }

    // MARK: - Encoding

    func encode(into data: inout Data, options: Document.EncodingOptions) {
        data.append(contentsOf: "<".utf8)
        data.append(contentsOf: name.utf8)
        encodeAttributes(into: &data, options: options)

        switch content {
        case .none:
            data.append(contentsOf: "/>".utf8)

        case .children(let children):
            data.append(contentsOf: ">".utf8)
            for child in children {
                child.encode(into: &data, options: options)
            }
            data.append(contentsOf: "</".utf8)
            data.append(contentsOf: name.utf8)
            data.append(contentsOf: ">".utf8)

        case .text(let text):
            data.append(contentsOf: ">".utf8)
            data.append(contentsOf: text.utf8)
            data.append(contentsOf: "</".utf8)
            data.append(contentsOf: name.utf8)
            data.append(contentsOf: ">".utf8)
        }
    }

    var encodedCapacity: Int {
        let base: Int =
            1 + // <
            name.utf8.count +
            encodedAttributesCapacity

        switch content {
        case .none:
            return
                base +
                2 // />

        case .children(let children):
            return
                base +
                1 + // >
                children.map({ (child) -> Int in child.encodedCapacity }).reduce(0, +) +
                2 + // </
                name.utf8.count +
                1 // >

        case .text(let string):
            return
                base +
                1 + // >
                string.utf8.count +
                2 + // </
                name.utf8.count +
                1 // >
        }
    }

    private func encodeAttributes(into data: inout Data, options: Document.EncodingOptions) {
        func encodePair(key: String, value: String) {
            data.append(contentsOf: " ".utf8)
            data.append(contentsOf: key.utf8)
            data.append(contentsOf: "=\"".utf8)
            data.append(contentsOf: value.utf8)
            data.append(contentsOf: "\"".utf8)
        }

        if options.shouldSortAttributeKeys {
            for (key, value) in attributes.sorted(by: { $0.key < $1.key }) {
                encodePair(key: key, value: value)
            }
        } else {
            for (key, value) in attributes {
                encodePair(key: key, value: value)
            }
        }
    }

    private var encodedAttributesCapacity: Int {
        guard !attributes.isEmpty else {
            return 0
        }

        return attributes
            .map { (attribute, key) -> Int in
                1 + // space before
                attribute.utf8.count +
                2 + // = and starting "
                key.utf8.count +
                1 // ending "
            }
            .reduce(0, +)
    }
}
