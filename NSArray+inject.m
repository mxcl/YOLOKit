#import "YOLO.ph"

@implementation NSArray (YOLO)

- (id(^)(id, id (^)(id, id)))inject {
    return ^(id initial_memo, id (^block)(id, id)) {
        BOOL wasNonMutable = [initial_memo classForCoder] == [NSArray class] || [initial_memo classForCoder] == [NSDictionary class];
        if (wasNonMutable)
            initial_memo = [initial_memo mutableCopy];

        id memo = initial_memo;
        for (id obj in self)
            memo = block(memo, obj);
        return wasNonMutable ? [memo copy] : memo;
    };
}

@end
