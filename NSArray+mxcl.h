#import <Foundation/Foundation.h>

@interface NSArray (RubyEnumerable)
- (id)map:(id (^)(id o))block;
- (id)select:(BOOL (^)(id o))block;
@end

@interface NSArray (mxcl)
- (id)sortedArrayUsingDescriptor:(NSSortDescriptor *)descriptor;
- (id)firstObject;
@end

@interface NSMutableArray (mxcl)
- (void)sortUsingDescriptor:(NSSortDescriptor *)descriptor;
@end
