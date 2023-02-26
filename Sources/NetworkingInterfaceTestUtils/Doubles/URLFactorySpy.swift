import Foundation
import NetworkingInterface

public final class URLFactorySpy: URLFactoryProtocol {
    public init() {}
    
    public private(set) var makeCalled: Bool = false
    public private(set) var makeRequestPassed: NetworkRequest?
    public var makeToBeReturned: URLRequest?
    
    public func make(from request: NetworkRequest) -> URLRequest? {
        makeCalled = true
        makeRequestPassed = request
        return makeToBeReturned
    }
}
