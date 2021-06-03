//
//  Created by Daniel Inoa on 1/1/21.
//

import UIKit

extension UILayoutPriority {
    static var fixedSpacingPriority: UILayoutPriority { .required }
    static var minimumSpacingPriority: UILayoutPriority { .defaultLow }
    static var equalSpacingPriority: UILayoutPriority { .minimumSpacingPriority - 1 }
    static var lowest: UILayoutPriority { .init(1) }
}
