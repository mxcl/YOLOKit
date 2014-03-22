#import "YOLO.h"
#import <objc/runtime.h>
extern int YOLOArgCount(id);
extern NSMethodSignature *YOLOMS(id);

/**
 The blockToUse variable is necessary or: EXC_BAD_ACCESS
**/
#define YOLOSelectReject(logic) \
    if (!input) return @[]; \
    BOOL (^blockToUse)(); \
    if (class_isMetaClass(object_getClass(input))) { \
        blockToUse = ^(id o){ \
            return [o isKindOfClass:input]; \
        }; \
    } else \
        blockToUse = input;\
    id selected[self.count]; \
    int ii = 0; \
    for (id o in self) \
        if (logic blockToUse(o)) \
            selected[ii++] = o; \
    return [NSArray arrayWithObjects:selected count:ii]


@implementation NSArray (RubyEnumerable)

- (NSArray *(^)(id))select {
    return ^(id input) {
        YOLOSelectReject(!!);
    };
}

- (NSArray *(^)(id))reject {
    return ^(id input) {
        YOLOSelectReject(!);
    };
}

- (NSArray *(^)(id))each {
    return ^(id frock) {
        NSMethodSignature *sig = YOLOMS(frock);
        void (^block)(id, NSUInteger) = ^{
            switch (sig.numberOfArguments){
                case 2: return ^(id a, NSUInteger b){ ((void(^)(id))frock)(a); };
                case 3:
                    return [sig getArgumentTypeAtIndex:2][0] == '@'
                        ? ^(id a, NSUInteger b){ ((void(^)(id, id))frock)(a, @(b)); }
                        : ^(id a, NSUInteger b){ ((void(^)(id, NSUInteger))frock)(a, b); };
                case 4:
                    return [sig getArgumentTypeAtIndex:2][0] == '@'
                        ? ^(id a, NSUInteger b){ ((void(^)(id, id, id))frock)(a, @(b), self); }
                        : ^(id a, NSUInteger b){ ((void(^)(id, NSUInteger, id))frock)(a, b, self); };
                default:
                    @throw @"Invalid argument count to each";
            }
        }();

        NSUInteger ii = 0;
        for (id obj in self)
            block(obj, ii++);
        return self;
    };
}

- (NSArray *(^)(id))map {
    return ^(id frock) {
        NSMethodSignature *sig = YOLOMS(frock);
        id (^block)(id, NSUInteger) = ^{
            switch (sig.numberOfArguments){
                case 2: return ^(id a, NSUInteger b){ return ((id(^)(id))frock)(a); };
                case 3:
                    return [sig getArgumentTypeAtIndex:2][0] == '@'
                        ? ^(id a, NSUInteger b){ return ((id(^)(id, id))frock)(a, @(b)); }
                        : ^(id a, NSUInteger b){ return ((id(^)(id, NSUInteger))frock)(a, b); };
                case 4:
                    return [sig getArgumentTypeAtIndex:2][0] == '@'
                        ? ^(id a, NSUInteger b){ return ((id(^)(id, id, id))frock)(a, @(b), self); }
                        : ^(id a, NSUInteger b){ return ((id(^)(id, NSUInteger, id))frock)(a, b, self); };
                default:
                    @throw @"Invalid argument count to map";
            }
        }();

        id mapped[self.count];
        NSUInteger ii = 0, jj = 0;
        for (id mappable in self) {
            id o = block(mappable, ii++);
            if (o)
                mapped[jj++] = o;
        }
        return [NSArray arrayWithObjects:mapped count:jj];
    };
}

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

- (id(^)(id (^)(id, id)))reduce {
    return ^(id (^block)(id, id)) {
        id memo = self.firstObject;
        for (id obj in self.last(self.count - 1))
            memo = block(memo, obj);
        return memo;
    };
}

- (id(^)(id))min {
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

- (id(^)(id))max {
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

- (id(^)(id))find {
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
    @try {
        if (self.all(^(id o){ return [o isKindOfClass:[NSString class]]; }))
            return [self sortedArrayUsingComparator:^(id obj1, id obj2){
                return [obj1 compare:obj2 options:NSCaseInsensitiveSearch|NSNumericSearch];
            }];
        else
            return [self sortedArrayUsingSelector:@selector(compare:)];
    } @catch (id e)
    {}

    return self.sortBy(@"description");
}

- (NSArray *(^)(id))sortBy {
    // TODO pass an array to sort by multiple selectors (use multiple sort descriptors)

    return ^(id blockOrKey) {
        if ([blockOrKey isKindOfClass:[NSString class]])
            blockOrKey = ^(id o){
                return [o valueForKey:blockOrKey];
            };

        // FIXME inefficient
        NSArray *keys = self.map(blockOrKey);
        return keys.sort.map(^(id key){
            NSUInteger ii = [keys indexOfObject:key];
            return self[ii];
        });
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

- (BOOL(^)(id o))all {
    return ^(id arg){
        BOOL (^block)(id o) = nil;

        if (arg == NSString.class /*or segfaults!*/ || class_isMetaClass(object_getClass(arg))) {
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

- (BOOL(^)(id o))none {
    return ^(id arg){
        BOOL (^block)(id o) = nil;

        if (arg == NSString.class /*or segfaults!*/ || class_isMetaClass(object_getClass(arg))) {
            Class cls = arg;
            block = ^(id o){
                return [o isKindOfClass:cls];
            };
        } else
            block = arg;

        for (id o in self)
            if (block(o))
                return NO;
        return YES;
    };
}

- (BOOL(^)(id))any {
    return ^(id arg){
        BOOL (^block)(id o) = nil;

        if (arg == NSString.class /*or segfaults!*/ || class_isMetaClass(object_getClass(arg))) {
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

- (NSArray *(^)(NSUInteger))first {
    return ^(NSUInteger num) {
        return self.slice(0, num);
    };
}

- (NSArray *(^)(NSUInteger))last {
    return ^(NSUInteger num) {
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
        return [self.pluck(@"description") componentsJoinedByString:separator ?: @""];
    };
}

- (NSArray *)transpose {
    if (self.empty)
        return self;

    NSArray *arrays = self.select(^(id o){
        return [o isKindOfClass:[NSArray class]];
    });
    NSInteger max = [arrays.max(^NSInteger(id o){
        return [o count];
    }) count];

    NSMutableArray *rv = [NSMutableArray new];
    for (int x = 0; x < max; ++x)
        [rv addObject:[NSMutableArray new]];

    arrays.each(^(NSArray *array){
        array.each(^(id o, uint ii) {
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

- (NSArray *(^)(NSInteger))rotate {
    return ^(NSInteger pivot) {
        if (pivot < 0)
            pivot = (int)self.count + pivot;
        return self.skip(pivot).concat(self.snip(pivot));
    };
}

@end
