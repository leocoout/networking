import NetworkingInterface

public final class NetworkingFactory {
    public init() {}
    
    public func make() -> NetworkingProtocol {
        let urlFactory = URLFactory()
        let resultHandler = NetworkRequestResultHandler()
        
        return Networking(
            urlFactory: urlFactory,
            resultHandler: resultHandler
        )
    }
}
