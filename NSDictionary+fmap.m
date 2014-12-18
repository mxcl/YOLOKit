#import "YOLO.ph"

@implementation NSDictionary (YOLO)

- (NSDictionary *(^)(id))fmap {
    return ^(id frock) {
        NSMethodSignature *sig = YOLOMS(frock);
        id (^block)(id, id) = ^{
            switch (sig.numberOfArguments){
                case 2: return ^(id v, id k){ return ((id(^)(id))frock)(v); };
                case 3: return ^(id v, id k){ return ((id(^)(id, id))frock)(v, k); };
                case 4: return ^(id v, id k){ return ((id(^)(id, id, id))frock)(v, k, self); };
                default:
                    @throw @"Invalid argument count to fmap";
            }
        }();

        id keys[self.count];
        id objs[self.count];
        int ii = 0;
        for (id key in self) {
            id o = block(self[key], key);
            if (o) {
                keys[ii]   = key;
                objs[ii++] = o;
            }
        }
        return [NSDictionary dictionaryWithObjects:objs forKeys:keys count:ii];
    };
}

@end
