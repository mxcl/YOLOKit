#import "NSSet+pluck.h"
#import "YOLO.ph"

@implementation NSSet (YOLOJoin)

- (NSString *(^)(NSString *))join {
    return ^(NSString *separator) {
        return [self.pluck(@"description").allObjects componentsJoinedByString:separator ?: @""];
    };
}

@end
