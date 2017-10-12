package hx;

import chrome.Windows;
import angular.Angular;
import angular.service.Scope;

class Login {

    static private var username = "";

    static private var password = "";

    static public function main() {
        var appController = function(scope:Scope) {
            var self = js.Lib.nativeThis;
            scope.set("username", username);
            scope.set("password", password);
            scope.set("click", function(h:History) {
                trace(self.username);
                trace(self.password);
            });
        }

        var module = Angular.module("appModule", [])
            .controller("appController", appController);
    }
}