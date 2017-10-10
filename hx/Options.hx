package hx;

import vue.Vue;
import js.Lib;

@:expose
class Options {

    public static var app:Vue;

    static public function main() {
        app = new Vue({
            el:"#app",
            created:function() {
                var self = Lib.nativeThis;
                Repository.instance.getHistories(function(r) {
                    self.histories = r;
                });
            },
            data: {
                histories:[]
            },
            methods:{
                click:function(url:String) {
                }
            }
        });
    }

}