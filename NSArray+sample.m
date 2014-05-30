#import <stdlib.h>
#import "YOLO.ph"

@implementation NSArray (YOLO)

- (id)sample {   
    return self[arc4random_uniform((u_int32_t)self.count)];
}

@end
