#import "YOLO.ph"

@implementation NSDictionary (YOLO)

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
