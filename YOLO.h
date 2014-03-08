#import <Foundation/Foundation.h>

/**
 Documentated online: https://github.com/mxcl/YOLOKit/blob/master/README.markdown
**/

@interface NSArray (RubyEnumerable)
- (BOOL(^)(id blockOrClass))all;
- (BOOL(^)(BOOL (^)(id o)))any;
- (NSArray *(^)(void (^)(id o)))each;
- (NSArray *(^)(void (^)(id o, uint index)))eachWithIndex;
- (id(^)(BOOL (^)(id o)))find;
- (NSArray *)flatten;
- (NSArray *(^)(NSArray *(^)(id o)))flatMap;
- (NSDictionary *(^)(id (^)(id o)))groupBy;
- (NSUInteger (^)(id obj))indexOf;
- (id(^)(id initial_memo, id (^)(id memo, id obj)))inject;
- (NSArray *(^)(id (^)(id o)))map;
- (id(^)(NSInteger (^)(id)))max;
- (id(^)(NSInteger (^)(id)))min;
- (BOOL(^)(id blockOrClass))none;
- (NSArray *(^)(id blockOrClass))select;
- (NSArray *)sort;
- (NSArray *(^)(id blockOrKey))sortBy;
- (id(^)(id (^)(id memo, id obj)))reduce;
- (NSArray *(^)(id blockOrClass))reject;
@end

@interface NSArray (Underscore)
- (NSArray *(^)(id blockReturningBool))partition;
- (NSArray *(^)(NSString *keypath))pluck;
- (NSArray *(^)(id arrayOrSetOrObject))without;
@end

@interface NSArray (Ruby)
- (NSArray *(^)(NSArray *other_array))concat;
- (NSArray *(^)(NSUInteger))first;  // @see last, slice, snip, skip
- (NSString *(^)(NSString *))join;
- (NSArray *(^)(NSUInteger))last;   // @see first, slice, snip, skip
- (NSArray *)reverse;
- (NSArray *(^)(NSInteger))rotate;
- (id)sample;
- (NSArray *)shuffle;
- (NSArray *(^)(NSUInteger start, NSUInteger length))slice;  // @see first, last, snip, skip
- (NSArray *)transpose;
- (NSArray *)uniq;
@end

@interface NSArray (YOLO)
- (NSArray *(^)(NSUInteger))chunk;
- (BOOL)empty;
- (BOOL (^)(id o))has;
- (NSArray *(^)(id (^)(id o)))pmap;
- (NSSet *)set;
- (NSArray *(^)(NSUInteger numberToTrim))snip;
- (NSArray *(^)(NSUInteger numberToSkip))skip;
@end

@interface NSMutableArray (YOLO)
- (id)pop;
- (NSMutableArray *(^)(id obj))push;
- (id)shift;
- (NSMutableArray *(^)(id obj))unshift;
@end

@interface NSSet (RubyEnumerable)
- (NSSet *(^)(void (^)(id o)))each;
@end

@interface NSDictionary (RubyEnumerable)
- (NSArray *(^)(id (^)(id key, id obj)))map;
@end

@interface NSDictionary (Underscore)
- (NSDictionary *(^)(id o, ...))extend;
@end

@interface NSDictionary (YOLO)
- (id (^)(id))get;
- (NSArray *)array;
@end

@interface NSNumber (Ruby)
- (NSArray *(^)(NSInteger))upTo;
@end

@interface NSString (YOLO)
- (NSArray *(^)(NSString *))split;
@end
