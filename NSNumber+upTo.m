#import "YOLO.ph"

@implementation NSNumber (YOLO)

- (NSArray *(^)(NSInteger))upTo {
    return ^NSArray *(NSInteger upTo) {
        NSInteger const start = self.intValue;
        NSInteger const count = upTo - start + 1;
        id objs[count];
        for (int x = 0; x < count; ++x)
            objs[x] = @(start + x);
        return [NSArray arrayWithObjects:objs count:count];
    };
}

@end
