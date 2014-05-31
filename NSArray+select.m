#import "YOLO.ph"
#import <objc/runtime.h>

extern int YOLOArgCount(id);
extern NSMethodSignature *YOLOMS(id);

@implementation NSArray (YOLO)

// The blockToUse variable is necessary or: EXC_BAD_ACCESS

#define YOLOSelectReject(logic) \
    if (!input) return @[]; \
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
    return [NSArray arrayWithObjects:selected count:ii]

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

@end
