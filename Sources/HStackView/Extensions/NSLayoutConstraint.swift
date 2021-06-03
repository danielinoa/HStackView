//
//  Created by Daniel Inoa on 1/1/21.
//

import UIKit

extension NSLayoutConstraint {

    func setPriority(_ priority: UILayoutPriority) -> Self {
        self.priority = priority
        return self
    }
}
