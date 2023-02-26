import Foundation
import NetworkingInterface

public final class URLSessionSpy: URLSessionProtocol {
    public init() {}
    
    public private(set) var dataCalled: Bool = false
    public private(set) var dataURLPassed: URL?
    public private(set) var dataDelegatePassed: URLSessionTaskDelegate?
    public var dataToBeReturned: (Data, URLResponse) = (Data(), URLResponse())
    
    public func data(from url: URL, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        dataCalled = true
        dataURLPassed = url
        dataDelegatePassed = delegate
        return dataToBeReturned
    }
    
    public private(set) var dataForRequestCalled: Bool = false
    public private(set) var dataForRequestPassed: URLRequest?
    public private(set) var dataForRequestDelegatePassed: URLSessionTaskDelegate?
    public var dataForRequestToBeReturned: (Data, URLResponse) = (Data(), URLResponse())
    
    public func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        dataForRequestCalled = true
        dataForRequestPassed = request
        dataForRequestDelegatePassed = delegate
        return dataForRequestToBeReturned
    }
}
