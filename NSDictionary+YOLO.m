#import "YOLO.h"


@implementation NSDictionary (YOLO)

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


@implementation NSDictionary (PListCompliant)

- (NSDictionary *)plistCompliantObject {
    NSMutableDictionary *dict = @{}.mutableCopy;
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj respondsToSelector:@selector(plistCompliantObject)]) {
            dict[key] = [obj plistCompliantObject];
        } else if (obj != [NSNull null]) {
            dict[key] = obj;
        }
    }];
    return dict;
}

@end
