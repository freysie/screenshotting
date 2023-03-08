extension Sequence {
  func uniqued<Type: Hashable>(by keyPath: KeyPath<Element, Type>) -> [Element] {
    var set = Set<Type>()
    return filter { set.insert($0[keyPath: keyPath]).inserted }
  }
}
