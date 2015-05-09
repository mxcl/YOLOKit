#import "YOLO.ph"

@implementation NSArray (YOLOMap)

- (NSArray *(^)(id))map {
    return ^id(id frock) {
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

@end
