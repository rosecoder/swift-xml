extension Node {

    /// Content for a node.
    ///
    /// Possible values:
    /// - `.none` – no content – neither children or text.
    /// - `.children([Node])` – an array of child nodes.
    /// - `.text(String)` – raw text body.
    public enum Content {

        /// No content – neither children or text.
        case none

        /// An array of child nodes.
        case children([Node])

        /// Raw text body.
        case text(String)
    }
}

extension Node.Content: ExpressibleByStringLiteral {

    /// Creates an instance initialized to the given string value.
    ///
    /// - Parameter value: The value of the new instance.
    public init(stringLiteral value: String) {
        self = .text(value)
    }
}
