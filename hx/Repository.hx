package hx;

import haxe.Http;
import haxe.Json;

class Repository {

    public static var instance(default,null) = new Repository();

    private function new() {}

    public function addHistory(url:String,onError:String -> Void) {
        var http = new Http(Constants.BASE_URL + "/histories");

        http.addHeader("Content-Type", "application/x-www-form-urlencoded");
        http.setPostData('url=$url');

        http.onError = onError;

        http.request(true);
    }

    public function getHistories(onResult:Array<History> -> Void) {
        var http = new Http(Constants.BASE_URL + "/histories");

        http.onData = function(r) {
            var result:Array<History> = Json.parse(r);
            onResult(result);
        }
        http.request();
    }
}