#import "NSDictionary+mxcl.h"

@implementation NSDictionary (mxcl)

- (id)massagedStringForKey:(id)key {
	NSString *s = self[key];
	if (![s isKindOfClass:[NSString class]])
		return nil;
	s = [s stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	if ([s length] == 0)
		return nil;
	return s;
}

@end
