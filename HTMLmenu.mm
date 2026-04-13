#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface HTMLMenuVC : UIViewController <WKUIDelegate, WKScriptMessageHandler>
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation HTMLMenuVC

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
    
    // โหลด HTML จาก string (ฝังในโค้ด)
    NSString *htmlString = @"<html>... เนื้อหา Fluorite.html ทั้งหมด ...</html>";
    [self.webView loadHTMLString:htmlString baseURL:nil];
}

// รับ message จาก JavaScript
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSDictionary *body = message.body;
    NSString *action = body[@"action"];
    id value = body[@"value"];
    
    if ([action isEqualToString:@"toggle_aimbot"]) {
        Vars.Aimbot = [value boolValue];
        NSLog(@"[NEXORA] Aimbot: %d", Vars.Aimbot);
    }
    else if ([action isEqualToString:@"toggle_esp"]) {
        Vars.Enable = [value boolValue];
        NSLog(@"[NEXORA] ESP: %d", Vars.Enable);
    }
    else if ([action isEqualToString:@"toggle_box"]) {
        Vars.Box = [value boolValue];
    }
    else if ([action isEqualToString:@"toggle_skeleton"]) {
        Vars.skeleton = [value boolValue];
    }
    else if ([action isEqualToString:@"toggle_lines"]) {
        Vars.lines = [value boolValue];
    }
    else if ([action isEqualToString:@"toggle_name"]) {
        Vars.Name = [value boolValue];
    }
    else if ([action isEqualToString:@"toggle_health"]) {
        Vars.Health = [value boolValue];
    }
    else if ([action isEqualToString:@"toggle_distance"]) {
        Vars.Distance = [value boolValue];
    }
    else if ([action isEqualToString:@"set_fov"]) {
        Vars.AimFov = [value floatValue];
    }
}

// ปรับขนาด WebView เมื่อหมุนจอ
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.webView.frame = self.view.bounds;
}

// ปุ่มปิด
- (void)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
