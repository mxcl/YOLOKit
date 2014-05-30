#import "YOLO.ph"

@implementation NSDictionary (YOLO)

- (NSDictionary *(^)(id, ...))extend {
    return ^NSDictionary *(NSDictionary *key, ...) {
        if (!key)
            return self;
        NSMutableDictionary *cp = self.mutableCopy;
        if ([key isKindOfClass:[NSDictionary class]]) {
            [cp addEntriesFromDictionary:key];
        } else {
            va_list args;
            va_start(args, key);
            cp[key] = va_arg(args, id);
            va_end(args);
        }
        return cp.copy;
    };
}

@end
