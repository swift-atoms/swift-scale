# swift-scale

Use this package when you need per-axis multiplicative factors of a fixed dimension, such as the scale part of a geometric transform, that you combine, invert and store. Start from `Scale<N, Scalar>`; a single factor is `Scale<1, Scalar>`, which also does scalar arithmetic and percent conversion. Use swift-percent instead when the value is a percentage you want to compare and print, and swift-ratio when the factor converts between two typed domains.

## Laws

- Equality and hashing compare factor by factor in index order, with the scalar's own equality, so a NaN factor makes a scale unequal to itself.
- Ordering exists only for one factor and follows the scalar's `<`.
- `identity`, `double`, `half` and `uniform(_:)` set every factor to the same value.
- Concatenation multiplies factor by factor; `identity` is its neutral element.
- Inversion takes the reciprocal of each factor, so a scale concatenated with its inverse is `identity` and inverting twice returns the original, both exactly when every reciprocal is representable and up to floating-point rounding otherwise. A zero factor inverts to infinity carrying the zero's sign.
- Negation negates every factor.
- `percent(_:)` divides by 100 and `percent` multiplies by 100.
- Coding uses an unkeyed array of exactly `N` factors in index order. Decoding fails on a shorter or longer array; `Scale<0, Scalar>` is the empty array. Encoding and decoding each need only the matching capability of `Scalar`.
