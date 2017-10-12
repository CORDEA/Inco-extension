package hx;

import haxe.Http;
import haxe.Json;
import chrome.Storage;

typedef Token = {
    var token:String;
}

class LoginRepository {

    static private var TOKEN_KEY = "token";

    public static var instance(default,null) = new LoginRepository();

    private function new() {}

    public function login(username:String,password:String,onResult:String -> Void) {
        var http = new Http(Constants.BASE_URL + "/login");

        http.setParameter("user", username);
        http.setParameter("pass", password);

        http.onError = function(e) {
            trace(e);
            onResult("");
        }
        http.onData = function(r) {
            var result:Token = Json.parse(r);
            onResult(result.token);
        }
        http.request();
    }

    // unused: for auto login
    public function check(token:String,onResult:Bool -> Void) {
        var http = new Http(Constants.BASE_URL);

        http.addHeader("Authorization", 'Bearer $token');
        http.onError = function(e) {
            trace(e);
            onResult(false);
        }
        http.onData = function(r) {
            onResult(true);
        }
        http.request();
    }

    public function getToken(onResult:String -> Void) {
        var obj = new Map<String, String>();
        obj[TOKEN_KEY] = "";

        Storage.sync.get(obj, function (items:Map<String,String>) {
            onResult(items[TOKEN_KEY]);
        });
    }

    public function setToken(token:String,onComplete:Void -> Void) {
        var obj = new Map<String, String>();
        obj[TOKEN_KEY] = token;

        Storage.sync.set(obj, onComplete);
    }
}