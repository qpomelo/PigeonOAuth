
# PigeonOAuth
A OAuth signature maker library.

# Example

```swift
import PigeonOAuth

let credential = PigeonOAuth.Credential(consumerKey: "Your consumer key or app id here.", consumerSecret: "Your consumer or app secret here.", accessToken: "token", accessSecret: "secret")
let maker = PigeonOAuth.Maker(credential: credential)
var headers = [:] // place your http headers here
let url = URLComponents(string: "https://api.twitter.com/1.1/statuses/user_timeline.json")
headers = maker.makeAuthorizationHeader(.get, url, headers)

var request = URLRequest(url: url)
request.httpMethod = "GET"
request.headers = headers
NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
    guard let data = data else { return }
    print(String(data: data, encoding: .utf8)!)
}

```
