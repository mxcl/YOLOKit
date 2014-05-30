#import "YOLO.ph"

@implementation NSDictionary (YOLO)

- (NSArray *)array {
    NSMutableArray *array = [NSMutableArray new];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){
        [array addObject:@[key, obj]];
    }];
    return array;
}

@end
