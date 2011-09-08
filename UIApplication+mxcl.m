#import "UIApplication+mxcl.h"

@implementation UIApplication (mxcl)
+ (NSString *)documentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}
@end
