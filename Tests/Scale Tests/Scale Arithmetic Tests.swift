import Foundation
import Scale
import Testing

@Suite
struct `Scaled arithmetic preserves the scale through unary and binary operations` {

    @Test
    func `binary operations preserve scale`() {
        let lhs: Scale<1, Double> = .init(6.0)
        let rhs: Scale<1, Double> = .init(2.0)

        #expect((lhs * rhs).value == 12.0)
        #expect((lhs / rhs).value == 3.0)
        #expect((lhs + rhs).value == 8.0)
        #expect((lhs - rhs).value == 4.0)
    }

    @Test
    func `unary operations preserve scale`() {
        let value: Scale<1, Double> = .init(-9.0)

        #expect((-value).value == 9.0)
        #expect(abs(value).value == 9.0)
        #expect(sqrt(Scale<1, Double>(9.0)).value == 3.0)
    }
}

@Suite struct `Scale coding preserves dimensions` {
    @Test(arguments: ["[]", "[1]", "[1,2,3]", "[1,null]"])
    func `Decoding rejects mismatched or invalid factors`(_ json: String) {
        #expect(throws: DecodingError.self) {
            try JSONDecoder().decode(Scale<2, Double>.self, from: Data(json.utf8))
        }
    }

    @Test func `Integer factors round trip without floating point requirements`() throws {
        let value = Scale<2, Int>(x: 2, y: 3)
        let data = try JSONEncoder().encode(value)
        #expect(data == Data("[2,3]".utf8))
        #expect(try JSONDecoder().decode(Scale<2, Int>.self, from: data) == value)
    }

    @Test func `Zero dimensions require an empty array`() throws {
        let value = try JSONDecoder().decode(Scale<0, Int>.self, from: Data("[]".utf8))
        #expect(try JSONEncoder().encode(value) == Data("[]".utf8))
        #expect(throws: DecodingError.self) {
            try JSONDecoder().decode(Scale<0, Int>.self, from: Data("[1]".utf8))
        }
    }

    @Test func `Encoding does not require decoding`() throws {
        struct Factor: Encodable { let value: Int }
        let scale = Scale<1, Factor>([Factor(value: 2)])
        #expect(try JSONEncoder().encode(scale) == Data(#"[{"value":2}]"#.utf8))
    }

    @Test func `Decoding does not require encoding`() throws {
        struct Factor: Decodable { let value: Int }
        let scale = try JSONDecoder().decode(
            Scale<1, Factor>.self,
            from: Data(#"[{"value":2}]"#.utf8)
        )
        #expect(scale[0].value == 2)
    }
}

@Test func `Scale value equality and hashing need only factor value semantics`() {
    let first = Scale<2, Int>(x: 2, y: 3)
    let equal = Scale<2, Int>(x: 2, y: 3)
    let reversed = Scale<2, Int>(x: 3, y: 2)
    #expect(first == equal)
    #expect(first != reversed)
    #expect(Set([first, equal, reversed]).count == 2)
}
