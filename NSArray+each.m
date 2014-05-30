#import "YOLO.ph"

@implementation NSArray (YOLO)

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

@end
