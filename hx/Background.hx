package hx;

import chrome.Tabs;
import hx.Handler;

class Background {
    static public function main() {
        var handler = new Handler();
        chrome.Tabs.onUpdated.addListener(function(tabId, changeInfo, tab) {
            handler.handle(tabId, tab);
        });
    }
}