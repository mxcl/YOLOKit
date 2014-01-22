#import "YOLO.h"


@implementation UIImage (YOLO)

- (UIColor *)color {
    CGSize size = {1, 1};
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(ctx, kCGInterpolationMedium);
    [self drawInRect:(CGRect){.size = size} blendMode:kCGBlendModeCopy alpha:1];
    uint8_t *data = CGBitmapContextGetData(ctx);
    UIColor *color = [UIColor colorWithRed:data[2] / 255.f green:data[1] / 255.f blue:data[0] / 255.f alpha:1];
    UIGraphicsEndImageContext();
    return color;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.color.dark ? UIStatusBarStyleLightContent : UIStatusBarStyleDefault;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 11, 11);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (UIImage *)croppedImage:(CGRect)cropRect {
    cropRect.origin.x *= self.scale;
    cropRect.origin.y *= self.scale;
    cropRect.size.height *= self.scale;
    cropRect.size.width *= self.scale;

    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, cropRect);
    UIImage *img = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    return img;
}

- (UIImage *)imageTintedWithColor:(UIColor *)color {
    CGRect rect = (CGRect){.size = self.size};
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, self.scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self drawInRect:rect];
    CGContextSetFillColorWithColor(ctx, [color CGColor]);
    CGContextSetBlendMode(ctx, kCGBlendModeSourceAtop);
    CGContextFillRect(ctx, rect);
    return UIGraphicsGetImageFromCurrentImageContext();
}

@end
