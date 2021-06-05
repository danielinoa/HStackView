//
//  Created by Daniel Inoa on 1/1/21.
//

extension Array {

    /// Sets the specified value for the specified `writableKeyPath` on every object in the array.
    @discardableResult
    func set<V>(_ writableKeyPath: ReferenceWritableKeyPath<Element, V>, to value: V) -> Self {
        forEach { $0[keyPath: writableKeyPath] = value }
        return self
    }

    /// Returns an array containing the elements that can be casted to the specified type.
    /// # Example
    /// ```
    /// let elements: [Any] = [1, "abc", 2, true, 3]
    /// let integers: [Int] = elements.compactCast(to: Int.self) // returns [1, 2, 3]
    /// ```
    func compactCast<T>(to type: T.Type) -> [T] {
        compactMap { $0 as? T }
    }

    /// Returns an array containing the non-nil elements.
    /// # Example
    /// ```
    /// let numbers: [Int] = [1, nil, 2, nil, 3].compact() // returns [1, 2, 3]
    /// ```
    func compact<T>() -> [T] where T? == Element {
        compactMap { $0 }
    }
}
