#import "YOLO.ph"

@implementation NSArray (YOLO)

- (NSArray *(^)(NSUInteger numberToTrim))snip {
    return ^(NSUInteger num){
        return self.slice(0, self.count - num);
    };
}

@end
