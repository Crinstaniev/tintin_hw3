import Text "mo:base/Text";
import Nat "mo:base/Nat";

actor Counter {
    stable var currentValue : Nat = 0;

    type HeaderField = (Text, Text);

    type StreamingCallbackHttpResponse = {
        body: Blob;
        token: ?Token;
    };

    type Token = {};

    type StreamingStrategy = {
        #Callback: {
            callback: shared (Token) -> async (StreamingCallbackHttpResponse);
            token: Token;
        }
    };

    type HttpRequest =  {
        method: Text;
        url: Text;
        headers: [HeaderField];        
        body: Blob;
    };

    type HttpResponse = {
        status_code: Nat16;
        headers: [HeaderField];
        body: Blob;
        streaming_strategy: ?StreamingStrategy;
    };

    public query func http_request(request: HttpRequest) : async HttpResponse {
        return {
            status_code = 200;
            headers = [];
            body = Text.encodeUtf8("<html><body>" # Nat.toText(currentValue) # "</html></body>");
            streaming_strategy = null;
        };
    };

    public func increment() : async () {
        currentValue += 1;
    };

    public query func get() : async Nat {
        return currentValue;
    };

    public func set(n : Nat) : async () {
        currentValue := n;
    };
}