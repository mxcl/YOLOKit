#import "YOLO.ph"

@implementation NSArray (YOLO)

- (NSArray *(^)(NSUInteger, NSUInteger))slice {
    return ^id(NSUInteger start, NSUInteger length) {
        NSUInteger const N = self.count;

        if (N == 0)
            return self;

        // forgive
        if (start > N - 1) start = N - 1;
        if (start + length > N) length = N - start;

        return [self subarrayWithRange:NSMakeRange(start, length)];
    };
}

@end
