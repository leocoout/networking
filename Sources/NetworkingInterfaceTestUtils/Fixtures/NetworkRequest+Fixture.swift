import Foundation
import NetworkingInterface

public struct NetworkRequestFixture: NetworkRequest {
    public let scheme: String
    public let baseUrl: String
    public let path: String
    public let method: NetworkRequestMethod
    public let body: Encodable?
    public var header: [String: String]
    public var queryParameters: [String : Any]?
    
    public init(
        scheme: String = "https",
        baseUrl: String = "url.com",
        path: String = "path",
        method: NetworkRequestMethod = .post,
        header: [String : String] = [:],
        body: Encodable? = nil,
        queryParameters: [String : Any]? = nil
    ) {
        self.scheme = scheme
        self.baseUrl = baseUrl
        self.path = path
        self.method = method
        self.header = header
        self.body = body
        self.queryParameters = queryParameters
    }
}
