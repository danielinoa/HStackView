//
//  Created by Daniel Inoa on 1/1/21.
//

import UIKit

extension NSLayoutConstraint {

    /// Sets the constraint priority to the specified value.
    func setPriority(_ priority: UILayoutPriority) -> Self {
        self.priority = priority
        return self
    }
}
