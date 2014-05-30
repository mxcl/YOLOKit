#import "YOLO.ph"

@implementation NSArray (YOLO)

- (NSArray *(^)(NSUInteger))first {
    return ^(NSUInteger num) {
        return self.slice(0, num);
    };
}

@end
