#import "YOLO.ph"

@implementation NSArray (YOLO)

- (NSArray *)transpose {
    if (self.count == 0)
        return self;

    NSArray *arrays = self.select(^(id o){
        return [o isKindOfClass:[NSArray class]];
    });
    NSInteger max = [arrays.max(^NSInteger(id o){
        return [o count];
    }) count];

    NSMutableArray *rv = [NSMutableArray new];
    for (int x = 0; x < max; ++x)
        [rv addObject:[NSMutableArray new]];

    arrays.each(^(NSArray *array){
        array.each(^(id o, uint ii) {
            [rv[ii] addObject:o];
        });
    });
    return rv;
}

@end
