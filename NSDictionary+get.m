#import "YOLO.ph"

@implementation NSDictionary (YOLO)

- (id (^)(id))get {
    return ^(id key) {
        return [self objectForKey:key];
    };
}

@end