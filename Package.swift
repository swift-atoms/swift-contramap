// swift-tools-version: 6.4
import PackageDescription

let package = Package(
    name: "swift-contramap",
    platforms: [.macOS(.v27), .iOS(.v27), .tvOS(.v27), .watchOS(.v27), .visionOS(.v27)],
    products: [.library(name: "Contramap", targets: ["Contramap"])],
    targets: [
        .target(name: "Contramap"),
        .testTarget(name: "Contramap Tests", dependencies: ["Contramap"]),
    ],
    swiftLanguageModes: [.v6]
)
for target in package.targets {
    target.swiftSettings = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableExperimentalFeature("Lifetimes"),
    ]
}
