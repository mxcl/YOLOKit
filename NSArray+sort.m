@import Foundation.NSKeyValueCoding;
#import "YOLO.ph"

@implementation NSArray (YOLO)

- (NSArray *)sort {
    @try {
        if (self.all(^(id o){ return [o isKindOfClass:[NSString class]]; }))
            return [self sortedArrayUsingComparator:^(id obj1, id obj2){
                return [obj1 compare:obj2 options:NSCaseInsensitiveSearch|NSNumericSearch];
            }];
        else
            return [self sortedArrayUsingSelector:@selector(compare:)];
    }
    @catch (id e) {}

    return self.sortBy(@"description");
}

- (NSArray *(^)(id))sortBy {
    // TODO pass an array to sort by multiple selectors (use multiple sort descriptors)

    return ^NSArray *(id blockOrKey) {
        if ([blockOrKey isKindOfClass:[NSString class]])
            blockOrKey = ^(id o){
                return [o valueForKeyPath:blockOrKey];
            };

        #define foo(TYPE) { TYPE (^block)(id) = blockOrKey;\
            return [self sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {\
                TYPE a = block(obj1);\
                TYPE b = block(obj2);\
                return (NSComparisonResult)(a - b);\
            }]; }

        const char rt = YOLOMS(blockOrKey).methodReturnType[0];
        switch (rt){
            case 'i':
            case 'l':
            case 'c':
            case 's':
                foo(long);
            case 'q':
                foo(long long);
            case 'I':
            case 'L':
            case 'C':
            case 'S':
                foo(unsigned long);
            case 'Q':
                foo(unsigned long long);
            case 'f':
            case 'd':
                foo(double);
            case '@': {
                id (^block)(id) = blockOrKey;
                return [self sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                    obj1 = block(obj1);
                    obj2 = block(obj2);
                    if ([obj1 isKindOfClass:[NSString class]] && [obj2 isKindOfClass:[NSString class]])
                        return [obj1 compare:obj2 options:NSCaseInsensitiveSearch|NSNumericSearch];
                    else
                        return [obj1 compare:obj2];
                }];
                break;
            }
            default:
                @throw @"Cannot handle sortBy block return type. Please fork and fix!";
                return nil;
        }
    };
}

- (NSComparisonResult)compare:(NSArray *)array {
    if (![array isKindOfClass:[NSArray class]])
        array = @[array];

    for (NSArray *o in @[self, array].transpose) {
        if (o.count == 2) {
            NSComparisonResult result = [o[0] compare:o[1]];
            if (result != NSOrderedSame)
                return result;
        }
    }
    return NSOrderedSame;
}

@end
