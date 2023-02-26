import Foundation
import NetworkingInterface

public class NetworkRequestResultHandler: NetworkRequestResultHandling {
    public init() {}
    
    public func handle<T: Codable>(_ input: NetworkRequestResultHandlerInput, response: T.Type) throws -> T {
        guard let urlResponse = input.response as? HTTPURLResponse else {
            throw NetworkRequestError.noResponse
        }
        
        switch urlResponse.statusCode {
        case 200...299:
            do {
                let decodedResponse = try JSONDecoder().decode(response.self, from: input.data)
                return decodedResponse
            } catch {
                print(error)
            }
            throw NetworkRequestError.decode
        case 401:
            throw NetworkRequestError.unauthorized
        default:
            throw NetworkRequestError.unknown
        }
    }
}
