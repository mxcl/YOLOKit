#import "YOLO.ph"

@implementation NSArray (YOLOIndexOf)

- (NSUInteger (^)(id obj))indexOf {
    return ^NSUInteger(id obj) {
        return [self indexOfObject:obj];
    };
}

@end
