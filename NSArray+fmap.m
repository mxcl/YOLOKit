#import "YOLO.ph"

@implementation NSArray (YOLO)

- (NSArray *(^)(id))fmap {
    return self.map;
}

@end
