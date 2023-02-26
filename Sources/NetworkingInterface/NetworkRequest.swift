public protocol NetworkRequest {
    var scheme: String { get }
    var baseUrl: String { get }
    var path: String { get }
    var method: NetworkRequestMethod { get }
    var header: [String: String] { get }
    var body: [String: Any]? { get }
}

public extension NetworkRequest {
    var scheme: String {
        "https"
    }
}

public enum NetworkRequestMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case put = "PUT"
    case post = "POST"
}
