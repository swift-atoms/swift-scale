public struct Scale<let N: Int, Scalar> {

    public var factors: InlineArray<N, Scalar>

    @inlinable
    public init(_ factors: consuming InlineArray<N, Scalar>) {
        self.factors = factors
    }
}

extension Scale: Sendable where Scalar: Sendable {}

extension Scale: Equatable where Scalar: FloatingPoint {

    @inlinable
    public static func == (lhs: Self, rhs: Self) -> Bool {
        for i in 0..<N {
            if lhs.factors[i] != rhs.factors[i] { return false }
        }
        return true
    }
}

extension Scale: Hashable where Scalar: Hashable & FloatingPoint {

    @inlinable
    public func hash(into hasher: inout Hasher) {
        (0..<N).forEach { i in
            hasher.combine(factors[i])
        }
    }
}

extension Scale: Comparable where N == 1, Scalar: FloatingPoint {

    @inlinable
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.value < rhs.value
    }
}

#if !hasFeature(Embedded)
    extension Scale: Codable where Scalar: Codable, Scalar: FloatingPoint {

        public init(from decoder: any Decoder) throws {
            var container = try decoder.unkeyedContainer()
            var factors = InlineArray<N, Scalar>(repeating: .zero)
            for i in 0..<N {
                factors[i] = try container.decode(Scalar.self)
            }
            self.init(factors)
        }

        public func encode(to encoder: any Encoder) throws {
            var container = encoder.unkeyedContainer()
            for i in 0..<N {
                try container.encode(factors[i])
            }
        }
    }
#endif

extension Scale {

    @inlinable
    public subscript(index: Int) -> Scalar {
        get { factors[index] }
        set { factors[index] = newValue }
    }
}

extension Scale where Scalar: ExpressibleByIntegerLiteral, Scalar: FloatingPoint {

    @inlinable
    public static var identity: Self {
        Self(InlineArray(repeating: 1))
    }

    @inlinable
    public static func uniform(_ factor: Scale<1, Scalar>) -> Self {
        Self(InlineArray(repeating: factor.value))
    }

    @inlinable
    public static var double: Self {
        Self(InlineArray(repeating: 2))
    }
}

extension Scale where Scalar: BinaryFloatingPoint {

    @inlinable
    public static var half: Self {
        Self(InlineArray(repeating: Scalar(0.5)))
    }
}

extension Scale where N == 1, Scalar: FloatingPoint {

    @inlinable
    public var value: Scalar {
        get { factors[0] }
        set { factors[0] = newValue }
    }

    @inlinable
    public init(_ value: Scalar) {
        self.init([value])
    }

    public static func percent(_ value: Scalar) -> Self { Self(value / 100) }

    public var percent: Scalar { value * 100 }
}

extension Scale where N == 1, Scalar: BinaryFloatingPoint {

    @inlinable
    @_disfavoredOverload
    public static var pi: Self { Self(Scalar.pi) }
}

extension Scale where N == 2 {

    @inlinable
    public var x: Scalar {
        get { factors[0] }
        set { factors[0] = newValue }
    }

    @inlinable
    public var y: Scalar {
        get { factors[1] }
        set { factors[1] = newValue }
    }

    @inlinable
    public init(x: Scalar, y: Scalar) {
        self.init([x, y])
    }
}

extension Scale where N == 3 {

    @inlinable
    public var x: Scalar {
        get { factors[0] }
        set { factors[0] = newValue }
    }

    @inlinable
    public var y: Scalar {
        get { factors[1] }
        set { factors[1] = newValue }
    }

    @inlinable
    public var z: Scalar {
        get { factors[2] }
        set { factors[2] = newValue }
    }

    @inlinable
    public init(x: Scalar, y: Scalar, z: Scalar) {
        self.init([x, y, z])
    }
}

extension Scale where Scalar: FloatingPoint {

    @inlinable
    public static func concatenate(
        _ lhs: Self,
        with rhs: Self
    ) -> Self {
        var result = lhs.factors
        (0..<N).forEach { i in
            result[i] = lhs.factors[i] * rhs.factors[i]
        }
        return Self(result)
    }

    @inlinable
    public func concatenating(_ other: Self) -> Self {
        Self.concatenate(self, with: other)
    }

    @inlinable
    public static func inverted(_ scale: Self) -> Self {
        var result = scale.factors
        (0..<N).forEach { i in
            result[i] = 1 / scale.factors[i]
        }
        return Self(result)
    }

    @inlinable
    public var inverted: Self {
        Self.inverted(self)
    }
}

extension Scale: ExpressibleByFloatLiteral
where N == 1, Scalar: ExpressibleByFloatLiteral & FloatingPoint {

    public typealias FloatLiteralType = Scalar.FloatLiteralType

    @inlinable
    public init(floatLiteral value: FloatLiteralType) {
        self.init(Scalar(floatLiteral: value))
    }
}

extension Scale: ExpressibleByIntegerLiteral
where N == 1, Scalar: ExpressibleByIntegerLiteral & FloatingPoint {

    public typealias IntegerLiteralType = Scalar.IntegerLiteralType

    @inlinable
    public init(integerLiteral value: IntegerLiteralType) {
        self.init(Scalar(integerLiteral: value))
    }
}
