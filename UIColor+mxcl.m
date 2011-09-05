#import "UIColor+mxcl.h"

@implementation UIColor (mxcl)
+(UIColor *)randomColor {
//    srandom(time(NULL));
    CGFloat red =  (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random()/(CGFloat)RAND_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}
@end
