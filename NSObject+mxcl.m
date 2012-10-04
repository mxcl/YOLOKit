#import "NSObject+mxcl.h"
#import <objc/runtime.h>

@implementation NSObject (mxcl)

- (void)dumpSelectors {
    unsigned n = 0;
    Method *methods = class_copyMethodList([self class], &n);
    for (int i = 0; i < n; ++i)
        NSLog(@"%@", NSStringFromSelector(method_getName(methods[i])));
    free(methods);
}

+ (id)objectWithJSONData:(NSData *)json {
    return [NSJSONSerialization JSONObjectWithData:json options:kNilOptions error:nil];
}

+ (id)objectWithJSONString:(NSString *)json {
    return [NSObject objectWithJSONData:[json dataUsingEncoding:NSUTF8StringEncoding]];
}

@end
