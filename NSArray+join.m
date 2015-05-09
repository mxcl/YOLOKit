#import "NSArray+pluck.h"
#import "YOLO.ph"

@implementation NSArray (YOLOJoin)

- (NSString *(^)(NSString *))join {
    return ^(NSString *separator) {
        return [self.pluck(@"description") componentsJoinedByString:separator ?: @""];
    };
}

@end
