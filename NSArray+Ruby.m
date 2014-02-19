#import "YOLO.h"
#import <objc/runtime.h>


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

- (NSArray *(^)(void (^)(id, uint)))eachWithIndex {
    return ^(void (^block)(id, uint)) {
        [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            block(obj, (uint)idx);
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
        for (id obj in self.last(self.count - 1))
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

- (NSUInteger (^)(id obj))indexOf {
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

- (NSArray *(^)(NSArray *(^)(id o)))flatMap {
    return ^(NSArray *(^block)(id o)){
        NSMutableArray *rv = [NSMutableArray new];
        for (id o in self) {
            id m = block(o);
            if (m)
                [rv addObjectsFromArray:m];
        }
        return rv;
    };
}

- (NSDictionary *(^)(id (^)(id o)))groupBy {
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

- (NSArray *)sort {
    return [self sortedArrayUsingSelector:@selector(compare:)];
}

// FIXME inefficient
- (NSArray *(^)(id (^)(id o)))sortBy {
    return ^(id (^block)(id)) {
        if ([block isKindOfClass:[NSString class]]) {
            id d = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
            return [self sortedArrayUsingDescriptors:@[d]];
        }

        NSArray *keys = self.map(block);
        return keys.sort.map(^(id key){
            NSUInteger ii = [keys indexOfObject:key];
            return self[ii];
        });
    };
}

- (BOOL(^)(id o))all {
    return ^(id arg){
        BOOL (^block)(id o) = nil;

        // this bizarre comparison to NSString.class because I got segfaults
        // otherwise
        if (arg == NSString.class || class_isMetaClass(object_getClass(arg))) {
            Class cls = arg;
            block = ^(id o){
                return [o isKindOfClass:cls];
            };
        } else
            block = arg;

        for (id o in self)
            if (!block(o))
                return NO;
        return YES;
    };
}

@end



@implementation NSArray (Ruby)

- (NSArray *(^)(NSUInteger, NSUInteger))slice {
    return ^id(NSUInteger start, NSUInteger length) {
        NSUInteger const N = self.count;

        if (N == 0)
            return self;

        // forgive
        if (start > N - 1) start = N - 1;
        if (start + length > N) length = N - start;

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

- (NSArray *(^)(uint))first {
    return ^(uint num) {
        return self.slice(0, num);
    };
}

- (NSArray *(^)(uint))last {
    return ^(uint num) {
        return self.slice(self.count - num, num);
    };
}

- (NSArray *)reverse {
    NSMutableArray *aa = self.mutableCopy;
    NSUInteger const N = self.count;
    NSUInteger const X = N / 2;
    for (NSUInteger x = 0; x < X; ++x) {
        id tmp = aa[x];
        aa[x] = aa[N - x - 1];
        aa[N - x - 1] = tmp;
    }
    return aa;
}

- (NSString *(^)(NSString *))join {
    return ^(NSString *separator) {
        return [self.pluck(@"description") componentsJoinedByString:separator];
    };
}

- (NSArray *)transpose {
    if (self.empty)
        return self;

    NSArray *arrays = self.select(^(id o){
        return [o isKindOfClass:[NSArray class]];
    });
    const int max = [arrays.max(^NSInteger(id o){
        return [o count];
    }) count];

    NSMutableArray *rv = [NSMutableArray new];
    for (int x = 0; x < max; ++x)
        [rv addObject:[NSMutableArray new]];

    arrays.each(^(NSArray *array){
        array.eachWithIndex(^(id o, uint ii) {
            [rv[ii] addObject:o];
        });
    });
    return rv;
}

- (id)shuffle {
    switch (self.count) {
        case 0:
        case 1:
            return self;
        case 2:
            return @[self[1], self[0]];
        default: {
            NSMutableArray *ll = [NSMutableArray arrayWithArray:self];
            for (NSUInteger i = ll.count - 1; i; --i) // Knuth-Fisher-Yates
                [ll exchangeObjectAtIndex:arc4random() % (i + 1) withObjectAtIndex:i];
            return ll;
        }
    }
}

- (id)sample {
    return self[arc4random() % self.count];
}

- (NSArray *(^)(int))rotate {
    return ^(int pivot) {
        if (pivot < 0)
            pivot = (int)self.count + pivot;
        return self.skip(pivot).concat(self.snip(pivot));
    };
}

@end
