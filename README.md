# swift-scale

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

Multi-axis scale factors with intrinsic arithmetic for Swift.

`Scale<N, Scalar>` carries `N` per-axis scale factors in an `InlineArray`, with axis accessors, concatenation, inversion, literal conversion, and intrinsic scalar arithmetic on the single-axis form.

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-atoms/swift-scale.git", branch: "main"),
]
```

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "Scale", package: "swift-scale"),
    ]
)
```

## Concepts

```swift
import Scale

let uniform: Scale<1, Double> = .init(2.0)
let planar = Scale<2, Double>(x: 2, y: 3)

let doubled = uniform * uniform
let restored = planar.concatenating(planar.inverted)
```

The package contains one product, `Scale`, and has no package dependencies. Scaling of tagged spatial and angular values is supplied by `swift-spatial` and `swift-angle`.

## Community

<!-- BEGIN: discussion -->
*Discussion thread will be created at first public release.*
<!-- END: discussion -->

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
