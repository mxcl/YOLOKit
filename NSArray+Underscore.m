#import "YOLO.h"
#import <objc/runtime.h>

@implementation NSArray (Underscore)

- (NSArray *(^)(id ))pluck {
    return ^NSArray *(id key) {
        if ([key isKindOfClass:[NSString class]])
            return [self valueForKeyPath:key];

        if (class_isMetaClass(object_getClass(key)))
            return self.select(^(id o){
                return [o isKindOfClass:key];
            });

        return @[];
    };
}

@end
