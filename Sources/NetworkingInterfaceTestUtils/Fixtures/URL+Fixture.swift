import Foundation

public extension URL {
    static func forcedURL() -> Self {
        .init(string: "https://google.com.br")!
    }
}
