import NetworkingInterface

public final class NetworkRequestResultHandlerSpy: NetworkRequestResultHandling {
    public init() {}
    
    public private(set) var handleCalled: Bool = false
    public private(set) var handleInputPassed: NetworkRequestResultHandlerInput?
    public var handleResultToBeReturned: Any?
    
    public func handle<T: Codable>(
        _ input: NetworkRequestResultHandlerInput,
        response: T.Type
    ) throws -> T {
        handleCalled = true
        handleInputPassed = input
        
        if let handleResultToBeReturned = handleResultToBeReturned as? T {
             return handleResultToBeReturned
        }
        
        throw NetworkRequestError.unknown
    }
}
