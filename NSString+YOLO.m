#import "YOLO.h"

@implementation NSString (YOLO)
- (BOOL)matches:(NSString *)pattern {
    return [self rangeOfString:pattern options:NSRegularExpressionSearch].location != NSNotFound;
}

- (NSNumber *)wordCount {
    __block int count = 0;
    [self enumerateSubstringsInRange:[self range]
                               options:NSStringEnumerationByWords
                            usingBlock:^(NSString *word,
                                         NSRange wordRange,
                                         NSRange enclosingRange,
                                         BOOL *stop)
        {
            count++;
        }
    ];
    return [NSNumber numberWithInt:count];
}

- (NSRange)range {
    return NSMakeRange(0, self.length);
}

- (NSString *)strippedString {
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)chuzzle {
    NSString *s = self.strippedString;
    return s.length == 0 ? nil : s;
}
@end
