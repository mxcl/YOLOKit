#import "NSObject+mxcl.h"

@implementation NSObject (mxcl)
- (void)dumpSelectors {
    unsigned n = 0;
    Method *methods = class_copyMethodList([self class], &n);
    for (int i = 0; i < n; ++i)
        NSLog(@"%@", NSStringFromSelector(method_getName(methods[i])));
    free(methods);
}
@end
