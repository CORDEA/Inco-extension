package hx;

import chrome.Windows;
import angular.Angular;
import haxe.ds.StringMap;
import angular.service.Scope;

class Options {

    static private var cipher:Cipher = null;

    static private var token:String = null;

    static private var histories:Array<History> = [];

    static private function refreshHistories(scope:Scope) {
        if (cipher == null) {
            Cipher.readPrivateKey("id_rsa.pem", function(key) {
                cipher = new Cipher(key);
                refreshHistories(scope);
            });
            return;
        }
        if (token == null) {
            LoginRepository.instance.getToken(function(t) {
                token = t;
                refreshHistories(scope);
            });
            return;
        }
        if (token.length < 1) {
            return;
        }
        HistoryRepository.instance.getHistories(token,function(r) {
            var historyMap = new StringMap<History>();
            for (history in r) {
                history.url = cipher.decrypt(history.url);
                if (historyMap.exists(history.url)) {
                    var newHistory = historyMap.get(history.url);
                    newHistory.count += 1;
                    historyMap.set(history.url, newHistory);
                    continue;
                }
                history.count = 1;
                historyMap.set(history.url, history);
            }
            for (v in historyMap) {
                histories.push(v);
            }
            scope.apply();
        });
    }

    static public function main() {
        var appController = function(scope:Scope) {
            scope.set("histories", histories);
            scope.set("click", function(h:History) {
                Windows.create({"url":h.url, "incognito":true});
            });

            refreshHistories(scope);
        }

        var module = Angular.module("appModule", [])
            .controller("appController", appController);
    }
}