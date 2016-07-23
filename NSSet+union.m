#import "YOLO.ph"

@implementation NSArray (YOLOConcat)

- (NSArray *(^)(NSArray *))concat {
    return ^(id other_array) {
        return [self arrayByAddingObjectsFromArray:other_array];
    };
}

@end
