#import "YOLO.ph"

@implementation NSSet (YOLOInject)

- (id(^)(id, id (^)(id, id)))inject {
    return ^(id initial_memo, id (^block)(id, id)) {
        BOOL wasNonMutable = [initial_memo classForCoder] == [NSArray class] || [initial_memo classForCoder] == [NSDictionary class] || [initial_memo classForCoder] == [NSSet class];
        if (wasNonMutable)
            initial_memo = [initial_memo mutableCopy];

        id memo = initial_memo;
        for (id obj in self)
            memo = block(memo, obj);
        return wasNonMutable ? [memo copy] : memo;
    };
}

@end
