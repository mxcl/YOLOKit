#import "YOLO.ph"

@implementation NSArray (YOLO)

- (NSArray *(^)(NSUInteger))chunk {
    return ^(NSUInteger size){
        id aa = [NSMutableArray new];
        const NSUInteger n = self.count / size;
        for (int x = 0; x < n; ++x)
            [aa addObject:self.slice(x*size, size)];
        return aa;
    };
}

@end
