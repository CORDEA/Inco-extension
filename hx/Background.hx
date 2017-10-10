package hx;

import chrome.Tabs;
import hx.Handler;

class Background {
    static public function main() {
        Cipher.readPrivateKey("", function(result) {
            var handler = new Handler(result);
            chrome.Tabs.onUpdated.addListener(function(tabId, changeInfo, tab) {
                handler.handle(tabId, tab);
            });
        });
    }
}