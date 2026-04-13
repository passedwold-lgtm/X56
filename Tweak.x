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
    
    // โหลด HTML จากไฟล์ในเครื่อง
    NSString *htmlPath = @"/Library/NexoraFF/Fluorite.html";
    if ([[NSFileManager defaultManager] fileExistsAtPath:htmlPath]) {
        NSURL *url = [NSURL fileURLWithPath:htmlPath];
        [self.webView loadFileURL:url allowingReadAccessToURL:url];
    } else {
        // Fallback HTML (ถ้าไม่มีไฟล์)
        NSString *htmlString = @"<html><body style='background:black;color:white;'><h1>NEXORA</h1><p>HTML not found</p></body></html>";
        [self.webView loadHTMLString:htmlString baseURL:nil];
    }
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSDictionary *body = message.body;
    NSString *action = body[@"action"];
    id value = body[@"value"];
    
    // ========== BRIDGE: HTML -> Native ==========
    if ([action isEqualToString:@"aimbot"]) {
        // Vars.Aimbot = [value boolValue];
        NSLog(@"[NEXORA] Aimbot: %@", value);
    }
    else if ([action isEqualToString:@"box"]) {
        // Vars.Box = [value boolValue];
        NSLog(@"[NEXORA] ESP Box: %@", value);
    }
    else if ([action isEqualToString:@"skeleton"]) {
        // Vars.skeleton = [value boolValue];
        NSLog(@"[NEXORA] Skeleton: %@", value);
    }
    else if ([action isEqualToString:@"lines"]) {
        // Vars.lines = [value boolValue];
        NSLog(@"[NEXORA] Lines: %@", value);
    }
    else if ([action isEqualToString:@"name"]) {
        // Vars.Name = [value boolValue];
        NSLog(@"[NEXORA] Name ESP: %@", value);
    }
    else if ([action isEqualToString:@"health"]) {
        // Vars.Health = [value boolValue];
        NSLog(@"[NEXORA] Health Bar: %@", value);
    }
    else if ([action isEqualToString:@"distance"]) {
        // Vars.Distance = [value boolValue];
        NSLog(@"[NEXORA] Distance: %@", value);
    }
    else if ([action isEqualToString:@"fov"]) {
        // Vars.AimFov = [value floatValue];
        NSLog(@"[NEXORA] FOV: %@", value);
    }
    else if ([action isEqualToString:@"speedhack"]) {
        // SpeedHack = [value boolValue];
        NSLog(@"[NEXORA] Speedhack: %@", value);
    }
    else if ([action isEqualToString:@"fly"]) {
        // Vars.fly = [value boolValue];
        NSLog(@"[NEXORA] Fly: %@", value);
    }
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

// ========== เรียกเปิดเมนูเมื่อโหลด tweak ==========
%ctor {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        NexoraWebMenu *menu = [[NexoraWebMenu alloc] init];
        [menu show];
    });
}
