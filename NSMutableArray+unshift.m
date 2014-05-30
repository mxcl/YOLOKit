#import "YOLO.ph"

@implementation NSMutableArray (YOLO)

- (NSMutableArray *(^)(id o))unshift {
    return ^(id o){
        if (o) [self insertObject:o atIndex:0];
        return self;
    };
}

@end
