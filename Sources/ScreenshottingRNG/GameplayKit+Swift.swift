#if canImport(GameplayKit)

// wait, this is not available on watchOS? aaaaaaaaaaaaa

import class GameplayKit.GKRandomSource

extension GKRandomSource: RandomNumberGenerator {
  public func next() -> UInt64 {
    let next1 = UInt64(bitPattern: Int64(nextInt()))
    let next2 = UInt64(bitPattern: Int64(nextInt()))
    return next1 ^ (next2 << 32)
  }
}

// TODO: decide on which is best:

@_exported import class GameplayKit.GKLinearCongruentialRandomSource
@_exported import class GameplayKit.GKMersenneTwisterRandomSource

//public typealias LinearCongruentialRandomSource = GKLinearCongruentialRandomSource
//public typealias MersenneTwisterRandomSource = GKMersenneTwisterRandomSource

#endif
