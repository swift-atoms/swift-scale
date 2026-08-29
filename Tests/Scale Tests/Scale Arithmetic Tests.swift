import Scale
import Testing

@Suite
struct `Scale Arithmetic Tests` {

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
