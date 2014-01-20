#import "YOLO.h"
#import <objc/runtime.h>


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
            [array addObject:obj];
    }
    return [NSArray arrayWithArray:array];
}

@end



void NSObjectDumpSelectors(NSObject *o) {
    unsigned n = 0;
    Method *methods = class_copyMethodList([o class], &n);
    for (int i = 0; i < n; ++i)
        NSLog(@"%@", NSStringFromSelector(method_getName(methods[i])));
    free(methods);
}
