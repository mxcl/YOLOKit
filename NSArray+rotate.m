#import "YOLO.ph"

@implementation NSArray (YOLO)

- (NSArray *(^)(NSInteger))rotate {
    return ^(NSInteger pivot) {
        if (pivot < 0)
            pivot = (int)self.count + pivot;
        return self.skip(pivot).concat(self.snip(pivot));
    };
}

@end
