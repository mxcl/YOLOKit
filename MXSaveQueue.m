#import "MXSaveQueue.h"
#import "NSFileManager+DirectoryLocations.h"


@implementation MXSaveQueue

- (id)initWithSaveFilename:(NSString *)path {
    self = [super init];
    self.maxConcurrentOperationCount = 1;
    if (self) {
        _path = [path hasPrefix:@"/"]
            ? path
            : [[[NSFileManager defaultManager] applicationSupportDirectory] stringByAppendingPathComponent:path];
    }
    return self;
}

- (void)addOperationWithBlock:(NSData *(^)(void))dataFeederBlock {
    [self cancelAllOperations];

    NSBlockOperation *op_ = [NSBlockOperation new];
    __weak NSBlockOperation *op = op_;
    [op addExecutionBlock:^{
        NSData *data = dataFeederBlock();
        if (!op.isCancelled)
            [data writeToFile:_path atomically:YES];
    }];

    [self addOperation:op];
}

@end
