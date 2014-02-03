#import "YOLO.h"

@implementation NSArray (Underscore)

- (NSArray *(^)(NSString *))pluck {
    return ^(NSString *key) {
        return [self valueForKeyPath:key];
    };
}

@end
