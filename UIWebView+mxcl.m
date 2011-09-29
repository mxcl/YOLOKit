#import "UIWebView+mxcl.h"

@implementation UIWebView (mxcl)
- (void)setScrollsToTop:(BOOL)scrollsToTop {
    for (UIScrollView *sv in self.subviews)
        if ([sv isKindOfClass:[UIScrollView class]] && [sv respondsToSelector:@selector(setScrollsToTop:)]) {
            sv.scrollsToTop = scrollsToTop;            
            scrollsToTop = NO; // you can only set one scrollsToTop to YES or none will do it
        }
}
@end
