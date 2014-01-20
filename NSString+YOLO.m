#import "YOLO.h"

@implementation NSString (YOLO)
- (BOOL)matches:(NSString *)pattern {
    return [self rangeOfString:pattern options:NSRegularExpressionSearch].location != NSNotFound;
}

- (NSRange)range {
    return NSMakeRange(0, self.length);
}

- (NSString *)strip {
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)chuzzle {
    NSString *s = self.strip;
    return s.length == 0 ? nil : s;
}
@end
