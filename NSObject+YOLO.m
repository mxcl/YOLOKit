#import <objc/runtime.h>

void NSObjectDumpSelectors(NSObject *o) {
    unsigned n = 0;
    Method *methods = class_copyMethodList([o class], &n);
    for (int i = 0; i < n; ++i)
        NSLog(@"%@", NSStringFromSelector(method_getName(methods[i])));
    free(methods);
}
