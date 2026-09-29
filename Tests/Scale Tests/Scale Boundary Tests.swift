import Scale
import Testing

@Suite
struct `Scale boundaries` {
    @Test
    func `the presets fill every factor`() {
        #expect(Scale<3, Double>.identity == Scale(x: 1, y: 1, z: 1))
        #expect(Scale<2, Double>.double == Scale(x: 2, y: 2))
        #expect(Scale<2, Double>.half == Scale(x: 0.5, y: 0.5))
        #expect(Scale<3, Double>.uniform(Scale(4)) == Scale(x: 4, y: 4, z: 4))
    }

    @Test
    func `concatenation multiplies factor by factor`() {
        let scale = Scale<2, Double>(x: 2, y: 3)
        #expect(scale.concatenating(Scale(x: 5, y: 7)) == Scale(x: 10, y: 21))
        #expect(scale.concatenating(.identity) == scale)
    }

    @Test
    func `a scale concatenated with its inverse is the identity`() {
        let scale = Scale<3, Double>(x: 2, y: 0.25, z: -4)
        #expect(scale.concatenating(scale.inverted) == .identity)
        #expect(scale.inverted.inverted == scale)
    }

    @Test
    func `inverting a zero factor gives infinity with the sign of the zero`() {
        let inverted = Scale<2, Double>(x: 0, y: -0.0).inverted
        #expect(inverted.x == .infinity)
        #expect(inverted.y == -.infinity)
    }

    @Test
    func `negation flips every factor`() {
        #expect(-Scale<3, Double>(x: 1, y: -2, z: 0) == Scale(x: -1, y: 2, z: 0))
    }

    @Test
    func `percent round trips`() {
        #expect(Scale<1, Double>.percent(50).value == 0.5)
        #expect(Scale<1, Double>(0.25).percent == 25)
        #expect(Scale<1, Double>.percent(0).value == 0)
    }

    @Test
    func `literals and ordering work for one factor`() {
        let two: Scale<1, Double> = 2
        let half: Scale<1, Double> = 0.5
        #expect(half < two)
        #expect(!(two < two))
        #expect(abs(Scale<1, Double>(-0.0)).value == 0)
    }

    @Test
    func `a NaN factor is not equal to itself`() {
        #expect(Scale<1, Double>(.nan) != Scale<1, Double>(.nan))
    }
}
