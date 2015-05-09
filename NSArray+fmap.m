#import "NSArray+map.h"
#import "YOLO.ph"

@implementation NSArray (YOLOFMap)

- (NSArray *(^)(id))fmap {
    return self.map;
}

@end
