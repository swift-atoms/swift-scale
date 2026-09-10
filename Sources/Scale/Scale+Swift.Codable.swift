#if !hasFeature(Embedded)
extension Scale: Encodable where Scalar: Encodable {

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.unkeyedContainer()
        for i in 0..<N {
            try container.encode(factors[i])
        }
    }
}

extension Scale: Decodable where Scalar: Decodable {

    public init(from decoder: any Decoder) throws {
        var container = try decoder.unkeyedContainer()
        if let count = container.count, count != N {
            throw DecodingError.dataCorruptedError(
                in: container, debugDescription: "Expected exactly \(N) scale factors"
            )
        }
        let factors: InlineArray<N, Scalar> = try InlineArray { _ in
            try container.decode(Scalar.self)
        }
        guard container.isAtEnd else {
            throw DecodingError.dataCorruptedError(
                in: container, debugDescription: "Expected exactly \(N) scale factors"
            )
        }
        self.init(factors)
    }
}
#endif
