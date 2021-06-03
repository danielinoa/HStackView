//
//  Created by Daniel Inoa on 1/1/21.
//

extension Array {

    @discardableResult
    func set<V>(_ kp: ReferenceWritableKeyPath<Element, V>, to value: V) -> Self {
        forEach { $0[keyPath: kp] = value }
        return self
    }

    func compactCast<T>(to type: T.Type) -> [T] {
        compactMap { $0 as? T }
    }

    func compact<T>() -> [T] where T? == Element {
        compactMap { $0 }
    }
}
