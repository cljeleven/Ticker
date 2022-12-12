
import PackageDescription

let package = Package(
    name: "Ticker",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "Ticker",
            targets: ["Ticker"])
    ],
    dependencies: [
    ],
    targets: [
        .binaryTarget(
            name: "Ticker",
            url: "https://github.com/cljeleven/Ticker/tree/main/output/Ticker.xcframework",
        )
    ]
)