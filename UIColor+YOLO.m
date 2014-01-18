#import "YOLO.h"
#define ARC4RANDOM_MAX 0x100000000
#define YOLORAND (((CGFloat)arc4random())/((CGFloat)ARC4RANDOM_MAX))


@implementation UIColor (YOLO)

+ (instancetype)randomColor {
    return [self colorWithRed:YOLORAND green:YOLORAND blue:YOLORAND alpha:1.0];
}

@end
