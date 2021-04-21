// swift-tools-version:5.3
import PackageDescription

let package = Package(name: "GaugeMeterView",
                      platforms: [.iOS(.v8)],
                      products: [.library(name: "GaugeMeterView",
                                          targets: ["GaugeMeterView"])],
                      targets: [.target(name: "GaugeMeterView",
                                        path: ".")],
                      swiftLanguageVersions: [.v5])
                      
