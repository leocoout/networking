import Foundation
import NetworkingInterface

public class URLFactory: URLFactoryProtocol {
    public init() {}
    
    public func make(from request: NetworkRequest) -> URLRequest? {
        guard let url = URLComponents.make(from: request).url else { return nil }
    
        return .make(from: url, and: request)
    }
}

private extension URLComponents {
    static func make(from request: NetworkRequest) -> Self {
        var urlComponents = URLComponents()
        urlComponents.scheme = request.scheme
        urlComponents.host = request.baseUrl
        urlComponents.path = request.path
        urlComponents.queryItems = request.makeQueryItems()
       
        return urlComponents
    }
}

private extension NetworkRequest {
    func makeQueryItems() -> [URLQueryItem] {
        var itemsToReturn: [URLQueryItem] = []
        
        if let body = body {
            for (key, value) in body {
                itemsToReturn.append(
                    .init(name: key, value: "\(value)")
                )
            }
        }
        
        return itemsToReturn
    }
}

private extension URLRequest {
    static func make(from url: URL, and request: NetworkRequest) -> Self? {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        for (key, value) in request.header {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        return urlRequest
    }
}
