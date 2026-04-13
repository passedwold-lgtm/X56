#import "NexoraWebMenu.h"
#import "Vars.h" // หรือไฟล์ที่เก็บ Vars ของเพื่อน

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
    
    // โหลด HTML จาก string (เพื่อนก็อป HTML ที่มีปุ่มลอย + เมนูมาใส่ตรงนี้)
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"Fluorite" ofType:@"html"];
    if (htmlPath) {
        [self.webView loadFileURL:[NSURL fileURLWithPath:htmlPath] allowingReadAccessToURL:[NSURL fileURLWithPath:htmlPath]];
    } else {
        // Fallback: โหลดจาก string
        NSString *htmlString = @"<html>...</html>"; // ใส่ HTML เพื่อนตรงนี้
        [self.webView loadHTMLString:htmlString baseURL:nil];
    }
}

// รับ message จาก JavaScript
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSDictionary *body = message.body;
    NSString *action = body[@"action"];
    id value = body[@"value"];
    
    if ([action isEqualToString:@"aimbot"]) {
        Vars.Aimbot = [value boolValue];
    } else if ([action isEqualToString:@"box"]) {
        Vars.Box = [value boolValue];
    } else if ([action isEqualToString:@"skeleton"]) {
        Vars.skeleton = [value boolValue];
    } else if ([action isEqualToString:@"lines"]) {
        Vars.lines = [value boolValue];
    } else if ([action isEqualToString:@"name"]) {
        Vars.Name = [value boolValue];
    } else if ([action isEqualToString:@"health"]) {
        Vars.Health = [value boolValue];
    } else if ([action isEqualToString:@"distance"]) {
        Vars.Distance = [value boolValue];
    } else if ([action isEqualToString:@"fov"]) {
        Vars.AimFov = [value floatValue];
    }
    
    NSLog(@"[NEXORA] %@ = %@", action, value);
}

- (void)show {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (window) {
        self.view.frame = window.bounds;
        [window.rootViewController presentViewController:self animated:YES completion:nil];
    }
}

- (void)hide {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
