@resultBuilder
public struct NodeBuilder {

    public static func buildBlock(_ nodes: [Node]...) -> [Node] {
        Array(nodes.joined())
    }

    public static func buildOptional(_ component: [Node]?) -> [Node] {
        component ?? []
    }

    public static func buildEither(first components: [Node]) -> [Node] {
        components
    }

    public static func buildEither(second components: [Node]) -> [Node] {
        components
    }

    public static func buildArray(_ components: [[Node]]) -> [Node] {
        Array(components.joined())
    }

    public static func buildLimitedAvailability(_ component: [Node]) -> [Node] {
        component
    }

    public static func buildExpression(_ expression: Node) -> [Node] {
        [expression]
    }
}
