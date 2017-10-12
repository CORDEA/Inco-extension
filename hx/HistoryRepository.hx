package hx;

import haxe.Http;
import haxe.Json;

class HistoryRepository {

    public static var instance(default,null) = new HistoryRepository();

    private function new() {}

    public function addHistory(url:String,onError:String -> Void) {
        var http = new Http(Constants.BASE_URL + "/histories");

        http.addHeader("Content-Type", "application/x-www-form-urlencoded");
        http.setPostData('url=$url');

        http.onError = onError;

        http.request(true);
    }

    public function getHistories(token:String,onResult:Array<History> -> Void) {
        var http = new Http(Constants.BASE_URL + "/histories");

        http.addHeader("Authorization", 'Bearer $token');

        http.onData = function(r) {
            var result:Array<History> = Json.parse(r);
            onResult(result);
        }
        http.request();
    }
}