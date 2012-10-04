#import "NSDictionary+mxcl.h"

@implementation NSDictionary (mxcl)

- (id)massagedStringForKey:(id)key {
	NSString *s = self[key];
	if (![s isKindOfClass:[NSString class]])
		return nil;
	s = [s stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	return s.length ? s : nil;
}

- (id)JSONData {
    return [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:nil];
}

- (id)JSONString {
    return [[NSString alloc] initWithData:[self JSONData] encoding:NSUTF8StringEncoding];
}

@end
