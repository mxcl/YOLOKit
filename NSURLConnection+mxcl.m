#import  "NSURLConnection+mxcl.h"

@interface MBURLConnection : NSURLConnection {
    NSMutableData *data;
    int rc;
}
@property (nonatomic, copy) void (^block200)(NSData *);
@property (nonatomic, copy) void (^badblock)(NSError *);
@end


@implementation MBURLConnection
@synthesize badblock, block200;
- (id)initWithRequest:(id)rq {
    self = [super initWithRequest:rq delegate:self];
    if (self) {
        data = [NSMutableData new];
    }
    return self;
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if (rc == 200) {
        block200(data);
    } else {
        badblock(nil);
    }
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    badblock(error);
}
- (void)connection:(id)connection didReceiveData:(id)newdata {
    [data appendData:newdata];
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response {
    rc = response.statusCode;
}
@end


@implementation NSURLConnection (Blocks)
+ (id)connectionWithRequest:(id)rq twohundred:(void (^)(NSData *))block200 epicfail:(void (^)(NSError *))badblock {
    MBURLConnection *conn = [[MBURLConnection alloc] initWithRequest:rq];
    conn.badblock = badblock;
    conn.block200 = block200;
    return conn;
}
@end
