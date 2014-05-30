#import "YOLO.h"

@implementation NSMutableArray (YOLO)

- (NSMutableArray *(^)(id))push {
    return ^(id o){
        if (o) [self addObject:o];
        return self;
    };
}

@end
