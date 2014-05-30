#import "YOLO.ph"

@implementation NSArray (YOLO)

- (id(^)(id))find {
    return ^id(BOOL (^block)(id o)) {
        for (id item in self)
            if (block(item))
                return item;
        return nil;
    };
}

@end
