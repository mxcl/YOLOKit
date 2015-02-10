#import "YOLO.ph"

@implementation NSSet (YOLO)

- (NSSet *(^)(id (^)(id)))fmap {
    return ^id(id (^block)(id)) {
        id mapped[self.count];
        NSUInteger ii = 0;
        for (id mappable in self) {
            id o = block(mappable);
            if (o)
                mapped[ii++] = o;
        }
        return [[NSSet alloc] initWithObjects:mapped count:ii];
    };
}

@end
