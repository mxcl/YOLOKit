#import "YOLO.ph"

@implementation NSSet (YOLO)

- (NSSet *(^)(void (^)(id)))each {
    return ^(void(^block)(id)) {
        [self enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
            block(obj);
        }];
        return self;
    };
}

@end
