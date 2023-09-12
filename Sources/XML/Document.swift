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

    /// Encodes the document to raw data.
    /// - Returns: Encoded data.
    public func encoded() -> Data {
        var output = Data()
        output.reserveCapacity(rootNode.encodedCapacity)
        rootNode.encode(into: &output)
        return output
    }
}
