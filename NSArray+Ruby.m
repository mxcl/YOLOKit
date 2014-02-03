#import "YOLO.h"


@implementation NSArray (RubyEnumerable)

- (NSArray *(^)(BOOL (^)(id)))select {
    return ^(BOOL(^block)(id)) {
        id objs[self.count];
        int ii = 0;
        for (id item in self) {
            if (block(item))
                objs[ii++] = item;
        }
        return [NSArray arrayWithObjects:objs count:ii];
    };
}

- (NSArray *(^)(BOOL (^)(id)))reject {
    return ^(BOOL(^block)(id)) {
        return self.select(^BOOL(id o) {
            return !block(o);
        });
    };
}

- (NSArray *(^)(void (^)(id)))each {
    return ^(void (^block)(id)) {
        for (id obj in self)
            block(obj);
        return self;
    };
}

- (NSArray *(^)(void (^)(id, uint)))each_with_index {
    return ^(void (^block)(id, uint)) {
        [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            block(obj, idx);
        }];
        return self;
    };
}

- (NSArray *(^)(id (^)(id)))map {
    return ^(id (^block)(id)) {
        id objs[self.count];
        int ii = 0;
        for (id item in self) {
            id o = block(item);
            if (o)
                objs[ii++] = o;
        }
        return [NSArray arrayWithObjects:objs count:ii];
    };
}

- (id(^)(id, id (^)(id, id)))inject {
    return ^(id initial_memo, id (^block)(id, id)) {
        id memo = initial_memo;
        for (id obj in self)
            memo = block(memo, obj);
        return memo;
    };
}

- (id(^)(id (^)(id, id)))reduce {
    return ^(id (^block)(id, id)) {
        id memo = self.firstObject;
        for (id obj in self.slice(1, -1))
            memo = block(memo, obj);
        return memo;
    };
}

- (id(^)(NSInteger (^)(id)))min {
    return ^(NSInteger (^block)(id o)) {
        NSInteger value = NSIntegerMax;
        id keeper = nil;
        for (id o in self) {
            NSInteger ov = block(o);
            if (ov < value) {
                value = ov;
                keeper = o;
            }
        }
        return keeper;
    };
}

- (id(^)(NSInteger (^)(id)))max {
    return ^(NSInteger (^block)(id o)) {
        NSInteger value = NSIntegerMin;
        id keeper = nil;
        for (id o in self) {
            NSInteger ov = block(o);
            if (ov > value) {
                value = ov;
                keeper = o;
            }
        }
        return keeper;
    };
}

- (id(^)(BOOL (^)(id)))find {
    return ^id(BOOL (^block)(id o)) {
        for (id item in self)
            if (block(item))
                return item;
        return nil;
    };
}

- (NSUInteger (^)(id obj))index_of {
    return ^NSUInteger(id obj) {
        return [self indexOfObject:obj];
    };
}

- (id)flatten {
    NSMutableArray *aa = [NSMutableArray array];
    for (id o in self) {
        if ([o isKindOfClass:[NSArray class]])
            [aa addObjectsFromArray:[o flatten]];
        else
            [aa addObject:o];
    }
    return aa;
}

- (NSArray *(^)(NSArray *(^)(id o)))flat_map {
    return ^(NSArray *(^block)(id o)){
        return self.map(block).flatten;
    };
}

- (NSDictionary *(^)(id (^)(id o)))group_by {
    return ^id(id (^block)(id)) {
        NSMutableDictionary *dict = [NSMutableDictionary new];
        for (id o in self) {
            id key = block(o);
            if (!dict[key])
                dict[key] = [NSMutableArray arrayWithObject:o];
            else
                [dict[key] addObject:o];
        }
        return dict;
    };
}

@end



@implementation NSArray (Ruby)

- (NSArray *(^)(int, int))slice {
    return ^id(int start, int length) {
        if (self.count == 0)
            return self;

        if (start < 0) start += self.count;
        if (length < 0) length = ((int)self.count) + length - start + 1;

        // YOLOKit is forgiving
        if (start > self.count - 1) start = self.count - 1;
        if (start + length > self.count) length = self.count - start;

        return [self subarrayWithRange:NSMakeRange(start, length)];
    };
}

- (id)uniq {
    return [[NSOrderedSet orderedSetWithArray:self] array];
}

- (NSArray *(^)(NSArray *))concat {
    return ^(id other_array) {
        return [self arrayByAddingObjectsFromArray:other_array];
    };
}

- (NSArray *(^)(NSUInteger))first {
    return ^(NSUInteger num) {
        return self.slice(0, num);
    };
}

- (NSArray *(^)(NSUInteger))last {
    return ^(NSUInteger num) {
        return self.slice(-num, num);
    };
}

@end
