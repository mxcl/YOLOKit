#import "YOLO.ph"

@implementation NSMutableArray (YOLOPush)

- (NSMutableArray *(^)(id))push {
    return ^(id o){
        if (o) [self addObject:o];
        return self;
    };
}

@end
