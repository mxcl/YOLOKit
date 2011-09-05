#import <Foundation/Foundation.h>

@interface NSURLConnection (Blocks)
+ (id)connectionWithRequest:(id)rq twohundred:(void (^)(NSData *))block200 epicfail:(void (^)(NSError *))badblock;
@end
