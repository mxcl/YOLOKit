#import "YOLO.ph"


@implementation NSArray (YOLO)

- (BOOL(^)(id o))all {
    return ^(id arg){
        BOOL (^block)(id o) = nil;

        if (arg == NSString.class /*or segfaults!*/ || YOLOIsClass(arg)) {
            Class cls = arg;
            block = ^(id o){
                return [o isKindOfClass:cls];
            };
        } else {
            switch ([YOLOMS(arg) getArgumentTypeAtIndex:1][0]) {
                case 'c': { block = ^(id o){ return ((BOOL(^)(char))arg)([o charValue]); }; break; }
                case 'i': { block = ^(id o){ return ((BOOL(^)(int))arg)([o intValue]); }; break; }
                case 's': { block = ^(id o){ return ((BOOL(^)(short))arg)([o shortValue]); }; break; }
                case 'l': { block = ^(id o){ return ((BOOL(^)(long))arg)([o longValue]); }; break; }
                case 'q': { block = ^(id o){ return ((BOOL(^)(long long))arg)([o longLongValue]); }; break; }
                case 'C': { block = ^(id o){ return ((BOOL(^)(unsigned char))arg)([o unsignedCharValue]); }; break; }
                case 'I': { block = ^(id o){ return ((BOOL(^)(unsigned))arg)([o unsignedIntValue]); }; break; }
                case 'S': { block = ^(id o){ return ((BOOL(^)(unsigned short))arg)([o unsignedShortValue]); }; break; }
                case 'L': { block = ^(id o){ return ((BOOL(^)(unsigned long))arg)([o unsignedLongValue]); }; break; }
                case 'Q': { block = ^(id o){ return ((BOOL(^)(unsigned long long))arg)([o unsignedLongLongValue]); }; break; }
                case 'f': { block = ^(id o){ return ((BOOL(^)(float))arg)([o floatValue]); }; break; }
                case 'd': { block = ^(id o){ return ((BOOL(^)(double))arg)([o doubleValue]); }; break; }
                case 'B': { block = ^(id o){ return ((BOOL(^)(BOOL))arg)([o boolValue]); }; break; }
                default:
                    block = arg;
                    break;
            }
        }

        for (id o in self)
            if (!block(o))
                return NO;
        return YES;
    };
}

@end
