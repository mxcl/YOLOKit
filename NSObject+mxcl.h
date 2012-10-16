#import <Foundation/Foundation.h>

@interface NSObject (mxcl)

- (void)dumpSelectors;

+ (id)objectWithJSONData:(NSData *)json;
+ (id)objectWithJSONString:(NSString *)json;

@end


@interface NSObject (PListCompliant)

// removes [NSNull null] from NSArrays and NSDictionaries
- (id)plistCompliantObject;

@end
