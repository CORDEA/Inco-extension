package hx;

import chrome.Windows;
import js.Browser;
import js.Lib;
import angular.Angular;
import angular.service.Scope;

class Login {

    static private var repository = LoginRepository.instance;

    static private var username = "";

    static private var password = "";

    // unused: for auto login
    static private function checkToken(onResult:Bool -> Void) {
        repository.getToken(function(token) {
            if (token.length < 1) {
                onResult(false);
            }
            repository.check(token, onResult);
        });
    }

    static private function login(username,password:String) {
        repository.login(
            username,
            password,
            function(token) {
                if (token.length < 1) {
                    return;
                }
                repository.setToken(token, function() {
                    Browser.location.href = "options.html";
                });
            }
        );
    }

    static public function main() {
        var appController = function(scope:Scope) {
            var self = Lib.nativeThis;
            scope.set("username", username);
            scope.set("password", password);
            scope.set("click", function(h:History) {
                login(self.username, self.password);
            });
        }

        var module = Angular.module("appModule", [])
            .controller("appController", appController);
    }
}