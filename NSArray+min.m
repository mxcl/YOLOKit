#import "YOLO.ph"

@implementation NSArray (YOLO)

- (id(^)(id))min {
    return ^(NSInteger (^block)(id o)) {
        NSInteger value = NSIntegerMax;
        id keeper = nil;
        for (id o in self) {
            NSInteger ov = block(o);
            if (ov < value) {
                value = ov;
                keeper = o;
            }
        }
        return keeper;
    };
}

@end
