#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface NexoraWebMenu : UIViewController <WKUIDelegate, WKScriptMessageHandler>
@property (nonatomic, strong) WKWebView *webView;
- (void)show;
- (void)hide;
@end
