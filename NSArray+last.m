#import "YOLO.ph"

@implementation NSArray (YOLO)

- (NSArray *(^)(NSUInteger))last {
    return ^(NSUInteger num) {
        return self.slice(self.count - num, num);
    };
}

@end
