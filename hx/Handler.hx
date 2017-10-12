package hx;

class Handler {

    private var url:String;

    public function new() { }

    public function handle(tabId:Int,tab:chrome.Tabs.Tab) {
        if (!tab.incognito || url == tab.url) {
            return;
        }
        url = tab.url;
        HistoryRepository.instance.addHistory(url,function(msg) {
            trace(msg);
        });
    }
}