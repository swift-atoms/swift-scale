extension Scale: Swift.Hashable where Scalar: Swift.Hashable & FloatingPoint {

    @inlinable
    public func hash(into hasher: inout Hasher) {
        (0..<N).forEach { i in
            hasher.combine(factors[i])
        }
    }
}
