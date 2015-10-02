#import "YOLO.ph"

@implementation NSSet (YOLOFlatten)

- (id)flatten {
    NSMutableSet *aa = [NSMutableSet set];
    for (id o in self) {
        if ([o isKindOfClass:[NSArray class]])
            [aa addObjectsFromArray:[o flatten]];
        else if ([o isKindOfClass:[NSSet class]])
            [aa addObjectsFromArray:[o allObjects]];
        else
            [aa addObject:o];
    }
    return aa;
}

@end
