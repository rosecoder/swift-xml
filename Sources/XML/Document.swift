import Foundation

/// A XML document.
public struct Document {

    /// Root node of the document.
    public var rootNode: Node

    /// Initializes a new document with a root node.
    /// - Parameters:
    ///   - rootNode: Initiailization closure of the root node.
    ///
    /// Example usage:
    /// ```
    /// let document = Document {
    ///     Node("root") {
    ///         Node("child1")
    ///         Node("child2")
    ///     }
    /// }
    /// ```
    public init(rootNode: () -> Node) {
        self.rootNode = rootNode()
    }

    /// Encoding options to be used when encoding.
    public struct EncodingOptions {

        /// Determines if attribute keys should be sorted before being encoded. Order of keys can be undefined if `false`. Defaults to `false`.
        public var shouldSortAttributeKeys: Bool

        /// Initializes a new set of options.
        /// - Parameters:
        ///   - shouldSortAttributeKeys: Determines if attribute keys should be sorted before being encoded. Order of keys can be undefined if `false`. Defaults to `false`.
        public init(shouldSortAttributeKeys: Bool = false) {
            self.shouldSortAttributeKeys = shouldSortAttributeKeys
        }
    }

    /// Encodes the document to raw data.
    /// - Parameters:
    ///   - options: Encoding options to be used. Optional.
    /// - Returns: Encoded data.
    public func encoded(options: EncodingOptions = .init()) -> Data {
        var output = Data()
        output.reserveCapacity(rootNode.encodedCapacity)
        rootNode.encode(into: &output, options: options)

        assert(rootNode.encodedCapacity == output.count)
        return output
    }
}
