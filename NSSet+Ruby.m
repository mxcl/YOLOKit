#import "YOLO.h"

@implementation NSSet (RubyEnumerable)

- (NSSet *(^)(void (^)(id)))each {
    return [^(void(^block)(id)) {
        [self enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
            block(obj);
        }];
        return self;
    } copy];
}

@end
