#import "YOLO.ph"

@implementation NSArray (YOLO)

- (NSArray *(^)(NSArray *(^)(id o)))flatMap {
    return ^(NSArray *(^block)(id o)){
        NSMutableArray *rv = [NSMutableArray new];
        for (id o in self) {
            id m = block(o);
            if (m)
                [rv addObjectsFromArray:m];
        }
        return rv;
    };
}

@end
