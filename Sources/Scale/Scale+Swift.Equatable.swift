extension Scale: Swift.Equatable where Scalar: Swift.Equatable {

    @inlinable
    public static func == (lhs: Self, rhs: Self) -> Bool {
        for i in 0..<N {
            if lhs.factors[i] != rhs.factors[i] { return false }
        }
        return true
    }
}
