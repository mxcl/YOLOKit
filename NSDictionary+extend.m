#import "YOLO.ph"

@implementation NSDictionary (YOLO)

- (NSDictionary *(^)(NSDictionary *))extend {
    return ^NSDictionary *(NSDictionary *key) {
        if (!key)
            return self;
        NSMutableDictionary *cp = self.mutableCopy;
        [cp addEntriesFromDictionary:key];
        return cp.copy;
    };
}

@end
