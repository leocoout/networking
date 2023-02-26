import NetworkingInterface

public final class NetworkingProtocolSpy: NetworkingProtocol {
    public init() {}
    
    public private(set) var requestCalled: Bool = false
    public private(set) var requestPassed: NetworkRequest?
    public private(set) var responseModelPassed: Any?
    public var requestToBeReturned: Any?
    
    public func request<T: Codable>(
        _ request: NetworkRequest,
        responseModel: T.Type
    ) async throws -> T {
        requestCalled = true
        requestPassed = request
        responseModelPassed = responseModel
        
        if let result = requestToBeReturned as? T {
            return result
        }
        
        throw NetworkRequestError.unknown
    }
}
