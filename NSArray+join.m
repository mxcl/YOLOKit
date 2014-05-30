#import "YOLO.ph"

@implementation NSArray (YOLO)

- (NSString *(^)(NSString *))join {
    return ^(NSString *separator) {
        return [self.pluck(@"description") componentsJoinedByString:separator ?: @""];
    };
}

@end
