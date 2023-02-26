import Foundation
import NetworkingInterface

public class Networking: NetworkingProtocol {

    // MARK: - Private Properties
    
    private let urlFactory: URLFactoryProtocol
    private let resultHandler: NetworkRequestResultHandling
    private let urlSession: URLSessionProtocol
    
    // MARK: - Initializer
    
    public init(
        urlFactory: URLFactoryProtocol,
        resultHandler: NetworkRequestResultHandling,
        urlSession: URLSessionProtocol = URLSession.shared
    ) {
        self.urlFactory = urlFactory
        self.resultHandler = resultHandler
        self.urlSession = urlSession
    }
    
    public func request<T: Codable>(
        _ request: NetworkRequest,
        responseModel: T.Type
    ) async throws -> T {
        guard let urlRequest = urlFactory.make(from: request) else {
            throw NetworkRequestError.unknown
        }

        do {
            let (data, response) = try await urlSession.data(for: urlRequest, delegate: nil)
            let handlerInput = NetworkRequestResultHandlerInput(response: response, data: data)
            return try resultHandler.handle(handlerInput, response: responseModel)
        } catch {
            throw NetworkRequestError.unknown
        }
    }
}
