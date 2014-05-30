#import "YOLO.h"

@implementation NSArray (YOLO)

- (NSString *(^)(NSString *))join {
    return ^(NSString *separator) {
        return [self.pluck(@"description") componentsJoinedByString:separator ?: @""];
    };
}

@end
