#import "YOLO.ph"

@implementation NSArray (YOLO)

- (NSUInteger (^)(id obj))indexOf {
    return ^NSUInteger(id obj) {
        return [self indexOfObject:obj];
    };
}

@end
