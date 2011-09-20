#import "UIView+mxcl.h"

@implementation UIView (mxcl)
- (NSArray *)allSubviews {
    NSMutableArray *views = [NSMutableArray array];
    for (UIView *view in self.subviews)
        [views addObjectsFromArray:[view allSubviews]];
    return views;
}
@end
