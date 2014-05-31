#import "YOLO.ph"

@implementation NSString (YOLO)

- (NSArray *(^)(NSString *))split {
    return ^NSArray *(NSString *separator){
        separator = separator.description;
        if (separator.length == 0) {
            const NSUInteger N = self.length;
            id chars[N];
            for (NSUInteger x = 0; x < N; ++x)
                chars[x] = [self substringWithRange:NSMakeRange(x, 1)];
            return [NSArray arrayWithObjects:chars count:N];
        } else
            return [self componentsSeparatedByString:separator];
    };
}

@end
