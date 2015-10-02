#import "YOLO.ph"

@implementation NSSet (YOLOFlatMap)

- (NSSet *(^)(NSSet *(^)(id o)))flatMap {
    return ^(NSSet *(^block)(id o)){
        NSMutableSet *rv = [NSMutableSet new];
        for (id o in self) {
            id m = block(o);
            if ([m isKindOfClass:[NSSet class]])
                [rv addObjectsFromArray:[m allObjects]];
            else
              [rv addObjectsFromArray:m];
        }
        return rv;
    };
}

@end
