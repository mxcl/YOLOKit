#import "YOLO.ph"

@implementation NSArray (YOLO)

- (NSArray *(^)(NSArray *))concat {
    return ^(id other_array) {
        return [self arrayByAddingObjectsFromArray:other_array];
    };
}

@end
