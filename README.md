# Networking

This package is a simple Networking SPM that uses new Swift Concurrecy with Async/Await, using Swift 5.7.

## Usage 

Start by creating your own **request** struct using the `NetworkRequest` protocol, that comes with available properties such as `path`,`baseUrl`, `method`, `body` etc

Here's an example of a `GetMovieDetails` struct responsible for getting details for a movie based on an injected `id`:

```swift
struct GetMovieDetails: NetworkRequest { 
   var id: String
   
   init(id: String) {
       self.prompt = prompt
   }
   
   var method: NetworkRequestMethod {
       .get  
   }
   
   var queryParameters: [String: Any]? {
       ["page": 1, "movie-id": id]
   }
}
```

Some properties are commonly used in more than one request. For example, the base URL. You can create an **extension** of `NetworkRequest` including all default values for the properties you dont want to repeat, avoiding duplicated code:

```swift

extension NetworkRequest {
  var baseUrl: String {
      "api.myURl.com"
  }
```

With the request ready to be called, call the `.request` method from **Networking** passing your newly created request and the object that should be parsed as your response

```swift
func get(movieId: String) async throws -> MovieDetailsResponse {
        let request = GetMovieDetails(id: movieId)
        return try await networking.request(request, responseModel: MovieDetailsResponse.self)
    }
```

## TestUtils

This package offers the `NetworkingInterfaceTestUtils` that should be added to your test targets. Basically, this target contains some doubles and fixtures to help you in your unit tests. 

For example, if you inject the `NetworkingProtocol` into a production Service class, you can also inject the `NetworkingProtocolSpy` into the ServiceTests class to mock different response scenarios

Made by me.
