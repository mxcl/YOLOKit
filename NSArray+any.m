#import "YOLO.ph"

@implementation NSArray (YOLO)

- (BOOL(^)(id))any {
    return ^(id arg){
        BOOL (^block)(id o) = nil;

        if (arg == NSString.class /*or segfaults!*/ || YOLOIsClass(arg)) {
            Class cls = arg;
            block = ^(id o){
                return [o isKindOfClass:cls];
            };
        } else
            block = arg;

        for (id o in self)
            if (block(o))
                return YES;
        return NO;
    };
}

@end
