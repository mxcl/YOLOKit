#import "YOLO.h"

@implementation NSArray (YOLO)

- (BOOL (^)(id o))has {
    return ^BOOL(id o){
        return [self containsObject:o];
    };
}

@end
