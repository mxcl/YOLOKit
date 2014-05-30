@import Foundation.NSKeyValueCoding;
#import "YOLO.h"

@implementation NSArray (YOLO)

- (NSArray *(^)(NSString *))pluck {
    return ^NSArray *(NSString *key) {
        if (!key.length)
            return self;

        return [self valueForKeyPath:key];
    };
}

@end
