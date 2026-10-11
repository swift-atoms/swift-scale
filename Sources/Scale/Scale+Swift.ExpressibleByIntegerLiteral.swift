extension Scale: Swift::ExpressibleByIntegerLiteral
where N == 1, Scalar: Swift::ExpressibleByIntegerLiteral & FloatingPoint {

    public typealias IntegerLiteralType = Scalar.IntegerLiteralType

    @inlinable
    public init(integerLiteral value: IntegerLiteralType) {
        self.init(Scalar(integerLiteral: value))
    }
}
