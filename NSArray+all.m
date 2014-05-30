#import "YOLO.ph"
#import <objc/runtime.h>

@implementation NSArray (YOLO)

- (BOOL(^)(id o))all {
    return ^(id arg){
        BOOL (^block)(id o) = nil;

        if (arg == NSString.class /*or segfaults!*/ || class_isMetaClass(object_getClass(arg))) {
            Class cls = arg;
            block = ^(id o){
                return [o isKindOfClass:cls];
            };
        } else
            block = arg;

        for (id o in self)
            if (!block(o))
                return NO;
        return YES;
    };
}

@end
