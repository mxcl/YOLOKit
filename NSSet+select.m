#import "YOLO.ph"
#import <objc/runtime.h>

@implementation NSSet (YOLOSelect)

// The blockToUse variable is necessary or: EXC_BAD_ACCESS

#define YOLOSelectReject(logic) \
    if (!input) return [NSSet set]; \
    BOOL (^blockToUse)(); \
    if (YOLOIsClass(input)) { \
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
    return [NSSet setWithObjects:selected count:ii]

- (NSSet *(^)(id))select {
    return ^(id input) {
        YOLOSelectReject(!!);
    };
}

- (NSSet *(^)(id))reject {
    return ^(id input) {
        YOLOSelectReject(!);
    };
}

@end
