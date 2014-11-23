#import <stdlib.h>
#import "YOLO.ph"

@implementation NSArray (YOLO)

- (id)sample {
    return self.count == 0
        ? nil
        : self[arc4random_uniform((u_int32_t)self.count)];
}

@end
