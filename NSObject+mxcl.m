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



@implementation NSDictionary (PListCompliant)

- (NSDictionary *)plistCompliantObject {
    NSMutableDictionary *dict = @{}.mutableCopy;
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj respondsToSelector:@selector(plistCompliantObject)]) {
            dict[key] = [obj plistCompliantObject];
        } else if (obj != [NSNull null]) {
            dict[key] = obj;
        }
    }];
    return dict;
}

@end



@implementation NSArray (PListCompliant)

- (id)plistCompliantObject {
    NSMutableArray *array = @[].mutableCopy;
    for (id obj in self) {
        if ([obj respondsToSelector:@selector(plistCompliantObject)])
            [array addObject:[obj plistCompliantObject]];
        else if (obj != [NSNull null])
            [array addObject:array];
    }
    return array;
}

@end
