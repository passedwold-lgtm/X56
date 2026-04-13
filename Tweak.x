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
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *controller = [[WKUserContentController alloc] init];
    [controller addScriptMessageHandler:self name:@"native"];
    config.userContentController = controller;
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    self.webView.UIDelegate = self;
    self.webView.backgroundColor = [UIColor blackColor];
    self.webView.opaque = NO;
    [self.view addSubview:self.webView];
    
    NSString *htmlPath = @"/Library/NexoraFF/Fluorite.html";
    if ([[NSFileManager defaultManager] fileExistsAtPath:htmlPath]) {
        NSURL *url = [NSURL fileURLWithPath:htmlPath];
        [self.webView loadFileURL:url allowingReadAccessToURL:url];
    } else {
        NSString *htmlString = @"<html><body style='background:black;color:white;'><h1>NEXORA</h1><p>HTML not found</p></body></html>";
        [self.webView loadHTMLString:htmlString baseURL:nil];
    }
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSDictionary *body = message.body;
    NSString *action = body[@"action"];
    id value = body[@"value"];
    
    if ([action isEqualToString:@"aimbot"]) {
        NSLog(@"[NEXORA] Aimbot: %@", value);
    }
    else if ([action isEqualToString:@"box"]) {
        NSLog(@"[NEXORA] ESP Box: %@", value);
    }
    else if ([action isEqualToString:@"skeleton"]) {
        NSLog(@"[NEXORA] Skeleton: %@", value);
    }
    else if ([action isEqualToString:@"lines"]) {
        NSLog(@"[NEXORA] Lines: %@", value);
    }
    else if ([action isEqualToString:@"name"]) {
        NSLog(@"[NEXORA] Name ESP: %@", value);
    }
    else if ([action isEqualToString:@"health"]) {
        NSLog(@"[NEXORA] Health Bar: %@", value);
    }
    else if ([action isEqualToString:@"distance"]) {
        NSLog(@"[NEXORA] Distance: %@", value);
    }
    else if ([action isEqualToString:@"fov"]) {
        NSLog(@"[NEXORA] FOV: %@", value);
    }
    else if ([action isEqualToString:@"speedhack"]) {
        NSLog(@"[NEXORA] Speedhack: %@", value);
    }
    else if ([action isEqualToString:@"fly"]) {
        NSLog(@"[NEXORA] Fly: %@", value);
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
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        window = [[UIApplication sharedApplication] keyWindow];
        if (!window && [[UIApplication sharedApplication] windows].count > 0) {
            window = [[UIApplication sharedApplication] windows].firstObject;
        }
#pragma clang diagnostic pop
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
