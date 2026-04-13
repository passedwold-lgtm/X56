#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface NexoraWebMenu : UIViewController <WKUIDelegate, WKScriptMessageHandler>
@property (nonatomic, strong) WKWebView *webView;
- (void)show;
- (void)hide;
@end

@implementation NexoraWebMenu

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // ตั้งค่า WebView
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *controller = [[WKUserContentController alloc] init];
    [controller addScriptMessageHandler:self name:@"native"];
    config.userContentController = controller;
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    self.webView.UIDelegate = self;
    self.webView.backgroundColor = [UIColor blackColor];
    self.webView.opaque = NO;
    [self.view addSubview:self.webView];
    
    // ========== HTML ฝังในโค้ด (สวย เท่ ไม่ต้องพึ่งไฟล์) ==========
    NSString *htmlString = @"<!DOCTYPE html>"
    "<html>"
    "<head>"
    "<meta name='viewport' content='width=device-width, initial-scale=1.0'>"
    "<style>"
    "*{margin:0;padding:0;box-sizing:border-box;font-family:system-ui,-apple-system,BlinkMacSystemFont,'Segoe UI',sans-serif;}"
    "body{background:linear-gradient(135deg,#0f172a,#0a0f1a);min-height:100vh;display:flex;justify-content:center;align-items:center;padding:20px;}"
    ".menu{background:rgba(15,23,42,0.95);backdrop-filter:blur(10px);border-radius:28px;border:1px solid rgba(255,95,31,0.3);width:100%;max-width:400px;overflow:hidden;box-shadow:0 25px 50px -12px rgba(0,0,0,0.5);}"
    ".header{background:linear-gradient(90deg,#ff5f1f,#ff8c42);padding:20px;text-align:center;}"
    ".header h1{color:white;font-size:24px;margin-bottom:4px;}"
    ".header p{color:rgba(255,255,255,0.8);font-size:12px;}"
    ".tab-bar{display:flex;background:#1e293b;}"
    ".tab{flex:1;text-align:center;padding:12px;color:#94a3b8;font-size:12px;font-weight:600;cursor:pointer;transition:all 0.2s;border-bottom:2px solid transparent;}"
    ".tab.active{color:#ff5f1f;border-bottom-color:#ff5f1f;}"
    ".content{padding:20px;}"
    ".feature{background:#1e293b;border-radius:16px;padding:12px 16px;margin-bottom:12px;display:flex;justify-content:space-between;align-items:center;cursor:pointer;}"
    ".feature span{color:#e2e8f0;font-size:14px;font-weight:500;}"
    ".switch{width:44px;height:24px;background:#334155;border-radius:30px;position:relative;transition:0.2s;}"
    ".switch.active{background:#ff5f1f;}"
    ".switch-knob{width:20px;height:20px;background:white;border-radius:50%;position:absolute;top:2px;left:2px;transition:0.2s;}"
    ".switch.active .switch-knob{left:22px;}"
    ".footer{padding:16px;text-align:center;border-top:1px solid rgba(255,255,255,0.1);}"
    ".footer button{background:#ff5f1f;border:none;padding:10px 20px;border-radius:30px;color:white;font-weight:600;width:100%;cursor:pointer;}"
    "</style>"
    "</head>"
    "<body>"
    "<div class='menu'>"
    "<div class='header'>"
    "<h1>🐍 NEXORA</h1>"
    "<p>by SATOO x DEEPSEEK</p>"
    "</div>"
    "<div class='tab-bar'>"
    "<div class='tab active' onclick='switchTab(\"aimbot\")'>AIMBOT</div>"
    "<div class='tab' onclick='switchTab(\"esp\")'>ESP</div>"
    "<div class='tab' onclick='switchTab(\"misc\")'>MISC</div>"
    "</div>"
    "<div class='content' id='content'>"
    "<div id='tab-aimbot'>"
    "<div class='feature' onclick='toggleFeature(\"aimbot\")'><span>Aimbot</span><div class='switch' id='aimbot-switch'><div class='switch-knob'></div></div></div>"
    "<div class='feature' onclick='toggleFeature(\"fov\")'><span>Show FOV Circle</span><div class='switch' id='fov-switch'><div class='switch-knob'></div></div></div>"
    "</div>"
    "<div id='tab-esp' style='display:none'>"
    "<div class='feature' onclick='toggleFeature(\"box\")'><span>ESP Box</span><div class='switch' id='box-switch'><div class='switch-knob'></div></div></div>"
    "<div class='feature' onclick='toggleFeature(\"lines\")'><span>ESP Lines</span><div class='switch' id='lines-switch'><div class='switch-knob'></div></div></div>"
    "<div class='feature' onclick='toggleFeature(\"skeleton\")'><span>Skeleton</span><div class='switch' id='skeleton-switch'><div class='switch-knob'></div></div></div>"
    "<div class='feature' onclick='toggleFeature(\"name\")'><span>Player Name</span><div class='switch' id='name-switch'><div class='switch-knob'></div></div></div>"
    "</div>"
    "<div id='tab-misc' style='display:none'>"
    "<div class='feature' onclick='toggleFeature(\"speedhack\")'><span>Speedhack</span><div class='switch' id='speedhack-switch'><div class='switch-knob'></div></div></div>"
    "<div class='feature' onclick='toggleFeature(\"fly\")'><span>Fly Mode</span><div class='switch' id='fly-switch'><div class='switch-knob'></div></div></div>"
    "</div>"
    "</div>"
    "<div class='footer'><button onclick='closeMenu()'>CLOSE MENU</button></div>"
    "</div>"
    "<script>"
    "function switchTab(tab){"
    "document.querySelectorAll('.tab').forEach(t=>t.classList.remove('active'));"
    "event.target.classList.add('active');"
    "document.getElementById('tab-aimbot').style.display='none';"
    "document.getElementById('tab-esp').style.display='none';"
    "document.getElementById('tab-misc').style.display='none';"
    "document.getElementById('tab-'+tab).style.display='block';}"
    "function toggleFeature(feature){"
    "var sw=document.getElementById(feature+'-switch');"
    "if(sw){sw.classList.toggle('active');"
    "var isOn=sw.classList.contains('active');"
    "window.webkit.messageHandlers.native.postMessage({action:feature,value:isOn});}}"
    "function closeMenu(){window.webkit.messageHandlers.native.postMessage({action:'close',value:true});}"
    "</script>"
    "</body>"
    "</html>";
    
    [self.webView loadHTMLString:htmlString baseURL:nil];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSDictionary *body = message.body;
    NSString *action = body[@"action"];
    id value = body[@"value"];
    
    if ([action isEqualToString:@"close"]) {
        [self hide];
    } else {
        NSLog(@"[NEXORA] %@ = %@", action, value);
        // TODO: เชื่อมกับ Vars จริง
    }
}

- (void)show {
    UIWindow *window = nil;
    if (@available(iOS 13.0, *)) {
        for (UIScene *scene in [UIApplication sharedApplication].connectedScenes) {
            if (scene.activationState == UISceneActivationStateForegroundActive && [scene isKindOfClass:[UIWindowScene class]]) {
                window = [(UIWindowScene *)scene windows].firstObject;
                break;
            }
        }
    }
    if (!window) {
        window = [UIApplication sharedApplication].keyWindow;
    }
    if (window) {
        self.view.frame = window.bounds;
        [window.rootViewController presentViewController:self animated:YES completion:nil];
    }
}

- (void)hide {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

%ctor {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        NexoraWebMenu *menu = [[NexoraWebMenu alloc] init];
        [menu show];
    });
}
