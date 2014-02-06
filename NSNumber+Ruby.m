#import "YOLO.h"


@implementation NSNumber (Ruby)

- (NSArray *(^)(int))upto {
    return ^NSArray *(int upto) {
        int const start = self.intValue;
        int const count = upto - start + 1;
        id objs[count];
        for (int x = 0; x < count; ++x)
            objs[x] = @(start + x);
        return [NSArray arrayWithObjects:objs count:count];
    };
}

@end
