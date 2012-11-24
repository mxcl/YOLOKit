#import "NSNumber+mxcl.h"

@implementation NSNumber (mxcl)
- (NSString *)localizedString {
    NSNumberFormatter *nf = [NSNumberFormatter new];
    [nf setNumberStyle: NSNumberFormatterDecimalStyle];
    return [nf stringFromNumber:self];
}
@end
