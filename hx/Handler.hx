package hx;

class Handler {

    private var url:String;

    private var privateKey:String;

    public function new(privateKey:String)  {
        this.privateKey = privateKey;
    }

    public function handle(tabId:Int,tab:chrome.Tabs.Tab) {
        if (!tab.incognito || url == tab.url) {
            return;
        }
        url = tab.url;
        Repository.instance.addHistory(url, function(msg) {
            trace(msg);
        });
    }
}