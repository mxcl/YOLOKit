#import "YOLO.h"


@implementation NSDictionary (YOLO)

- (id (^)(id))get {
    return ^(id key) {
        return [self objectForKey:key];
    };
}

- (NSArray *)array {
    NSMutableArray *array = [NSMutableArray new];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){
        [array addObject:@[key, obj]];
    }];
    return array;
}

@end