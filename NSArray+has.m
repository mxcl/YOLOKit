#import "YOLO.ph"

@implementation NSArray (YOLOHas)

- (BOOL (^)(id o))has {
    return ^BOOL(id o){
        return [self containsObject:o];
    };
}

@end
