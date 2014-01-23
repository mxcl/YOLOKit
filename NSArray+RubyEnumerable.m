#import "YOLO.h"


@implementation NSArray (RubyEnumerable)

- (NSArray *(^)(BOOL (^)(id)))select {
    return ^(BOOL(^block)(id)) {
        return [self select:^BOOL(id o) {
            return block(o);
        }];
    };
}

- (NSArray *(^)(BOOL (^)(id)))reject {
    return ^(BOOL(^block)(id)) {
        return [self reject:^BOOL(id o) {
            return block(o);
        }];
    };
}

- (NSArray *(^)(NSString *))pick {
    return ^(NSString *key) {
        return [self valueForKeyPath:key];
    };
}

- (NSArray *(^)(void (^)(id)))each {
    return ^(void (^block)(id)) {
        [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            block(obj);
        }];
        return self;
    };
}



- (id)inject:(id (^)(id memo, id obj))block {
    return [self inject:nil block:block];
}

- (id)inject:(id)memo block:(id (^)(id memo, id obj))block {
    for (id obj in self)
        memo = block(memo, obj);
    return memo;
}

- (NSArray *)map:(id (^)(id obj))block {
    id objs[self.count];
    int ii = 0;
    for (id item in self) {
        id o = block(item);
        if (o)
            objs[ii++] = o;
    }
    return [NSArray arrayWithObjects:objs count:ii];
}

- (id)select:(BOOL (^)(id o))block {
    id objs[self.count];
    int ii = 0;
    for (id item in self) {
        if (block(item))
            objs[ii++] = item;
    }
    return [NSArray arrayWithObjects:objs count:ii];
}

- (id)reject:(BOOL (^)(id o))block {
    return [self select:^BOOL(id o) {
        return !block(o);
    }];
}

- (id)find:(BOOL (^)(id o))block {
    for (id item in self)
        if (block(item))
            return item;
    return nil;
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

- (id)min:(NSInteger (^)(id o))block {
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
}

@end
