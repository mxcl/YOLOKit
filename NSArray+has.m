#import "YOLO.ph"

@implementation NSArray (YOLO)

- (BOOL (^)(id o))has {
    return ^BOOL(id o){
        return [self containsObject:o];
    };
}

@end
