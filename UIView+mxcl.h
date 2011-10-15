#import <UIKit/UIKit.h>

@interface UIView (mxcl)
- (NSArray *)allSubviews;
- (void)dumpViewTree; // eg. [[[UIApplication sharedApplication] keyWindow] dumpViewTree];
@end
