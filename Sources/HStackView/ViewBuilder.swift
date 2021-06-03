//
//  Created by Daniel Inoa on 1/1/21.
//

import UIKit

@resultBuilder
public enum ViewBuilder {
    public static func buildBlock(_ components: Content...) -> Content { components.flatMap(\.content) }
    public static func buildOptional(_ component: Content?) -> Content { component.map { $0.content } ?? [] }
    public static func buildEither(first component: Content) -> Content { component }
    public static func buildEither(second component: Content) -> Content { component }
}

public protocol Content {
    var content: [UIView] { get }
}

extension UIView: Content {
    public var content: [UIView] { [self] }
}

extension Array: Content where Element: Content {
    public var content: [UIView] { flatMap(\.content) }
}
