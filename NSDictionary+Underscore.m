#import "YOLO.h"


@implementation NSDictionary (Underscore)

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

- (NSDictionary *(^)(id, ...))pick {
    return ^(id arg0, ...) {
        va_list args;
        va_start(args, arg0);
        NSMutableArray *keys = [NSMutableArray new];
        NSMutableArray *objs = [NSMutableArray new];
        id key = arg0;
        do {
            id obj = self[key];
            if (obj) {
                [keys addObject:key];
                [objs addObject:obj];
            }
        } while ((key = va_arg(args, id)));
        va_end(args);
        return [NSDictionary dictionaryWithObjects:objs forKeys:keys];
    };
}

@end
