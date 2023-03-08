import Foundation

/// - Important: bad bc global state
public struct Rand48RandomNumberGenerator: RandomNumberGenerator {
  public init(seed: Int) { srand48(seed) }
  public func next() -> UInt64 { UInt64(drand48() * Double(UInt64.max)) }
}
