//
//  Created by Daniel Inoa on 1/1/21.
//

import UIKit

/// A SwiftUI and UIToolbar-inspired view that arranges its subviews along the horizontal axis.
public final class HStackView: UIView {

    private let contentGuide = UILayoutGuide()

    /// Instantiates a horizontal stack view with the given views and vertical alignment.
    public init(items: [UIView], alignment: Alignment = .center) {
        super.init(frame: .zero)
        addLayoutGuide(contentGuide)
        items
            .compactCast(to: UIView.self)
            .set(\.translatesAutoresizingMaskIntoConstraints, to: false)
            .forEach(addSubview)
        let spacers = items.compactCast(to: Spacer.self)
        let spacersConstraints = spacersSizeConstraints(spacers)
        let stackingConstraints = stackingConstraints(for: items, within: contentGuide)
        let alignmentConstraints = verticalAlignmentConstraints(for: items, alignedAs: alignment, within: contentGuide)
        let contentGuideConstraints = constrainContentGuide()
        let constraints = stackingConstraints + alignmentConstraints + contentGuideConstraints + spacersConstraints
        NSLayoutConstraint.activate(constraints)
    }

    /// Instantiates a horizontal stack view with the given views and vertical alignment.
    public convenience init(alignment: Alignment = .center, @ViewBuilder _ builder: () -> Content) {
        let items = builder().content
        self.init(items: items, alignment: alignment)
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// The view that influences the height of this view.
    /// It is anchored to the top and bottom edges, such that it pushes this container vertically as it grows,
    /// without being streched (as long as it has an assigned or intrinsic height).
    /// - note: The specified must be in this view's hierarchy.
    @discardableResult
    public func anchorVerticalEdges(to view: UIView, top: CGFloat = .zero, bottom: CGFloat = .zero) -> Self {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: contentGuide.topAnchor, constant: top).isActive = true
        view.bottomAnchor.constraint(equalTo: contentGuide.bottomAnchor, constant: -bottom).isActive = true
        return self
    }

    private func spacersSizeConstraints(_ spacers: [Spacer]) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        let lastFlexibleSpacer = spacers.last { spacer in
            if case .flexible = spacer.strategy { return true }
            else { return false }
        }
        spacers.forEach { spacer in
            spacer.translatesAutoresizingMaskIntoConstraints = false
            addSubview(spacer)
            switch spacer.strategy {
            case .flexible(let space):
                constraints.append(
                    spacer.widthAnchor.constraint(
                        greaterThanOrEqualToConstant: space
                    ).setPriority(.minimumSpacingPriority)
                )
                if spacer != lastFlexibleSpacer, let lastFlexibleSpacer = lastFlexibleSpacer {
                    constraints.append(
                        spacer.widthAnchor.constraint(
                            equalTo: lastFlexibleSpacer.widthAnchor
                        ).setPriority(.equalSpacingPriority)
                    )
                }
            case .fixed(let constant):
                constraints.append(
                    spacer.widthAnchor.constraint(equalToConstant: constant).setPriority(.fixedSpacingPriority)
                )
            }
        }
        spacers.forEach { item in
            constraints.append(item.topAnchor.constraint(equalTo: contentGuide.topAnchor).setPriority(.lowest))
            constraints.append(item.bottomAnchor.constraint(equalTo: contentGuide.bottomAnchor).setPriority(.lowest))
        }
        return constraints
    }

    private func constrainContentGuide() -> [NSLayoutConstraint] {
        [
            contentGuide.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentGuide.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentGuide.topAnchor.constraint(equalTo: topAnchor),
            contentGuide.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]
    }

    private func stackingConstraints(for views: [UIView], within container: UILayoutGuide) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        for (index, item) in views.enumerated() {
            if item === views.first {
                constraints.append(item.leadingAnchor.constraint(equalTo: container.leadingAnchor))
            } else {
                let previousItem = views[index - 1]
                constraints.append(item.leadingAnchor.constraint(equalTo: previousItem.trailingAnchor))
            }
            if item === views.last {
                constraints.append(item.trailingAnchor.constraint(equalTo: container.trailingAnchor))
            }
        }
        return constraints
    }

    // MARK: - Alignment

    private func verticalAlignmentConstraints(
        for views: [UIView], alignedAs alignment: Alignment, within container: UILayoutGuide
    ) -> [NSLayoutConstraint] {
        let attribute: NSLayoutConstraint.Attribute
        switch alignment {
        case .top: attribute = .top
        case .center: attribute = .centerY
        case .bottom: attribute = .bottom
        }
        return views.map {
            .init(item: $0, attribute: attribute, relatedBy: .equal,
                  toItem: container, attribute: attribute, multiplier: 1, constant: 0)
        }
    }

    // MARK: - Intrinsic Size

    /// The size for this view based on the tallest arranged-subview and with no intrinsic width.
    public override var intrinsicContentSize: CGSize {
        let maxIntrinsicHeight = subviews.map(\.intrinsicContentSize.height).max() ?? UIView.noIntrinsicMetric
        return .init(width: UIView.noIntrinsicMetric, height: maxIntrinsicHeight)
    }
}

extension HStackView {

    /// The layout that defines the position of the `arrangedSubviews` along the vertical axis.
    public enum Alignment {

        /// A layout where `arrangedSubviews` are vertically-aligned towards the top edge.
        case top

        /// A layout where `arrangedSubviews` are vertically-aligned within the center.
        case center

        /// A layout where `arrangedSubviews` are vertically-aligned towards the bottom edge.
        case bottom
    }
}
