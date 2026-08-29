@inlinable
public func * <Scalar: FloatingPoint>(
    lhs: Scale<1, Scalar>,
    rhs: Scale<1, Scalar>
) -> Scale<1, Scalar> {
    Scale(lhs.value * rhs.value)
}

@inlinable
public func / <Scalar: FloatingPoint>(
    lhs: Scale<1, Scalar>,
    rhs: Scale<1, Scalar>
) -> Scale<1, Scalar> {
    Scale(lhs.value / rhs.value)
}

@inlinable
public func + <Scalar: FloatingPoint>(
    lhs: Scale<1, Scalar>,
    rhs: Scale<1, Scalar>
) -> Scale<1, Scalar> {
    Scale(lhs.value + rhs.value)
}

@inlinable
public func - <Scalar: FloatingPoint>(
    lhs: Scale<1, Scalar>,
    rhs: Scale<1, Scalar>
) -> Scale<1, Scalar> {
    Scale(lhs.value - rhs.value)
}

@inlinable
public func sqrt<Scalar: FloatingPoint>(
    _ value: Scale<1, Scalar>
) -> Scale<1, Scalar> {
    Scale(value.value.squareRoot())
}

extension Scale where Scalar: SignedNumeric & FloatingPoint {

    @inlinable
    public static prefix func - (scale: Self) -> Self {
        var result = scale.factors
        (0..<N).forEach { i in
            result[i] = -scale.factors[i]
        }
        return Self(result)
    }
}

@inlinable
public func abs<Scalar: FloatingPoint & Comparable>(
    _ value: Scale<1, Scalar>
) -> Scale<1, Scalar> {
    value.value < 0 ? Scale(-value.value) : value
}
