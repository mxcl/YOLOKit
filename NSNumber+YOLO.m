#import "YOLO.h"

@implementation NSNumber (YOLO)
- (NSString *)localizedString {
    NSNumberFormatter *nf = [NSNumberFormatter new];
    [nf setNumberStyle: NSNumberFormatterDecimalStyle];
    return [nf stringFromNumber:self];
}
@end
