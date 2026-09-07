extension Scale: Swift.Comparable where N == 1, Scalar: FloatingPoint {

    @inlinable
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.value < rhs.value
    }
}
