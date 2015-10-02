#import "YOLO.ph"

@implementation NSSet (YOLOHas)

- (BOOL (^)(id o))has {
    return ^BOOL(id o){
        return [self containsObject:o];
    };
}

@end
