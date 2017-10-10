package hx;

import com.hurlant.util.der.PEM;
import com.hurlant.util.Hex;
import com.hurlant.util.ByteArray;
import chrome.Runtime;
import js.html.FileReader;
import haxe.crypto.Base64;

class Cipher {

    private var privateKey:String;

    public function new(privateKey:String) {
        this.privateKey = privateKey;
    }

    public function decrypt(encrypted:String):String {
        var rsa = PEM.readRSAPrivateKey(privateKey);
        var bytes = Base64.decode(encrypted);
        var dest = new ByteArray();
        rsa.decrypt(bytes, dest, bytes.length);

        return Hex.toString(Hex.fromArray(dest));
    }

    static public function readPrivateKey(name:String,onResult:String -> Void) {
        Runtime.getPackageDirectoryEntry(function(root) {
            root.getFile(name, {}, function(entry) {
                entry.file(function(file) {
                    var reader = new FileReader();
                    reader.onloadend = function() {
                        onResult(reader.result);
                    }
                    reader.readAsText(file);
                }, function(e) {
                    trace(e);
                });
            }, function(e) {
                trace(e);
            });
        });
    }
}