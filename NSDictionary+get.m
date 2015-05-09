#import "YOLO.ph"

@implementation NSDictionary (YOLOGet)

- (id (^)(id))get {
    return ^(id key) {
        return [self objectForKey:key];
    };
}

@end