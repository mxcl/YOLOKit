#import "YOLO.ph"

@implementation NSMutableArray (YOLO)

- (NSMutableArray *(^)(id))push {
    return ^(id o){
        if (o) [self addObject:o];
        return self;
    };
}

@end
