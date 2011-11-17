#import <Foundation/Foundation.h>

@interface NSArray (RubyEnumerable)
- (id)map:(id (^)(id o))block;
- (id)select:(BOOL (^)(id o))block;
@end

@interface NSArray (mxcl)
- (id)sortedArrayUsingDescriptor:(NSSortDescriptor *)descriptor;
- (id)firstObject;

// Do not use this if there a chance that all values are equal
// or if most of the values are equal.
- (id)shuffledArray;
@end

@interface NSMutableArray (mxcl)
- (void)sortUsingDescriptor:(NSSortDescriptor *)descriptor;
@end
