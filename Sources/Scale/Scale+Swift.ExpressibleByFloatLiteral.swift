extension Scale: Swift::ExpressibleByFloatLiteral
where N == 1, Scalar: Swift::ExpressibleByFloatLiteral & FloatingPoint {

    public typealias FloatLiteralType = Scalar.FloatLiteralType

    @inlinable
    public init(floatLiteral value: FloatLiteralType) {
        self.init(Scalar(floatLiteral: value))
    }
}
