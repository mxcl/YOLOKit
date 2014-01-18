#import "YOLO.h"
#define ARC4RANDOM_MAX 0x100000000
#define YOLORAND (((CGFloat)arc4random())/((CGFloat)ARC4RANDOM_MAX))


@implementation UIColor (YOLO)

- (BOOL)dark {
    float r, g, b, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    uint8_t pixelR = r * 255.f;
    uint8_t pixelG = g * 255.f;
    uint8_t pixelB = b * 255.f;

    // Calculate the perceived luminance of the pixel; the human eye favors green, followed by red, then blue.
    double percievedLuminance = 1 - (((0.299 * pixelR) + (0.587 * pixelG) + (0.114 * pixelB)) / 255);

    return percievedLuminance >= 0.5;
}

+ (instancetype)randomColor {
    return [self colorWithRed:YOLORAND green:YOLORAND blue:YOLORAND alpha:1.0];
}

@end
