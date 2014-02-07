#import "YOLO.h"


@implementation NSString (YOLO)

- (NSArray *(^)(NSString *))split {
    return ^NSArray *(NSString *separator){
        return [self componentsSeparatedByString:separator];
    };
}

@end
