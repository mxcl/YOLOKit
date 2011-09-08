#import "NSNumber+mxcl.h"

@implementation NSNumber (mxcl)
- (NSString *)localizedString {
    NSNumberFormatter *nf = [NSNumberFormatter new];
    [nf setNumberStyle: NSNumberFormatterDecimalStyle];
    NSString *s = [nf stringFromNumber:self];
    [nf release];
    return s;
}
@end
