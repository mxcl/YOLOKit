#import "YOLO.h"

@implementation NSDictionary (RubyEnumerable)

- (NSArray *(^)(id (^)(id, id)))map {
    return ^(id (^block)(id, id)) {
        id objs[self.count];
        int ii = 0;
        for (id key in self) {
            id o = block(key, self[key]);
            if (o)
                objs[ii++] = o;
        }
        return [NSArray arrayWithObjects:objs count:ii];
    };
}

@end
