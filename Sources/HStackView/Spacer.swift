//
//  Created by Daniel Inoa on 1/1/21.
//

import UIKit

/// A spacer that that is either fixed or expanded along the main axis of its containing stack layout.
public final class Spacer: UIView {

    let strategy: Strategy

    enum Strategy {
        case flexible(minimum: CGFloat)
        case fixed(constant: CGFloat)
    }

    public convenience init(minimum: CGFloat = .zero) {
        self.init(strategy: .flexible(minimum: minimum))
    }

    public convenience init(fixed: CGFloat) {
        self.init(strategy: .fixed(constant: fixed))
    }

    private init(strategy: Strategy) {
        self.strategy = strategy
        super.init(frame: .zero)
        backgroundColor = .clear
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
