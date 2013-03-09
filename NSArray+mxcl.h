#import <Foundation/Foundation.h>

@interface NSArray (RubyEnumerable)
- (NSArray *)map:(id (^)(id o))block;
- (NSArray *)select:(BOOL (^)(id o))block;
- (NSArray *)reject:(BOOL (^)(id o))block;
- (id)find:(BOOL (^)(id o))block;
- (NSArray *)flatten;

- (id)min:(NSInteger (^)(id o))block;

- (id)inject:(id (^)(id memo, id obj))block;
- (id)inject:(id)initialMemo block:(id (^)(id memo, id obj))block;

@end

@interface NSArray (mxcl)
- (id)firstObject;

// Do not use this if there a chance that all values are equal
// or if most of the values are equal.
- (NSArray *)shuffledArray;

- (NSData *)JSONData;
- (NSString *)JSONString;

// like Ruby, preserves sort order
- (NSArray *)uniq;

@end

@interface NSMutableArray (mxcl)
- (id)pop;
@end
