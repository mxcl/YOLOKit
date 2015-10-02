@import Foundation.NSKeyValueCoding;
#import "YOLO.ph"

@implementation NSSet (YOLOPluck)

- (NSSet *(^)(NSString *))pluck {
    return ^NSSet *(NSString *key) {
        if (!key.length)
            return self;

        return [self valueForKeyPath:key];
    };
}

@end
