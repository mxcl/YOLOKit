@import Foundation.NSKeyValueCoding;
#import "YOLO.ph"

@implementation NSArray (YOLOPluck)

- (NSArray *(^)(NSString *))pluck {
    return ^NSArray *(NSString *key) {
        if (!key.length)
            return self;

        return [self valueForKeyPath:key];
    };
}

@end
