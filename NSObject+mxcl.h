#import <Foundation/Foundation.h>

@interface NSObject (mxcl)

- (void)dumpSelectors;

+ (id)objectWithJSONData:(NSData *)json;
+ (id)objectWithJSONString:(NSString *)json;

@end
