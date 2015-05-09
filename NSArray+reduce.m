#import "NSArray+last.h"
#import "YOLO.ph"

@implementation NSArray (YOLOReduce)

- (id(^)(id (^)(id, id)))reduce {
    return ^(id (^block)(id, id)) {
        id memo = self.firstObject;
        for (id obj in self.last(self.count - 1))
            memo = block(memo, obj);
        return memo;
    };
}

@end
