#import <stdlib.h>
#import "YOLO.ph"

@implementation NSArray (YOLO)

- (id)shuffle {
    switch (self.count) {
        case 0:
        case 1:
            return self;
        case 2:
            return @[self[1], self[0]];
        default: {
            NSMutableArray *ll = [NSMutableArray arrayWithArray:self];
            for (NSUInteger i = ll.count - 1; i; --i) // Knuth-Fisher-Yates
                [ll exchangeObjectAtIndex:arc4random() % (i + 1) withObjectAtIndex:i];
            return ll;
        }
    }
}

@end
