#import <Foundation/Foundation.h>

/**
 Documentated online: https://github.com/mxcl/YOLOKit/blob/master/README.markdown
**/

@interface NSArray (RubyEnumerable)
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
- (NSArray *(^)(BOOL (^)(id o)))select;
- (NSArray *)sort;
- (NSArray *(^)(id (^)(id o)))sortBy;
- (id(^)(id (^)(id memo, id obj)))reduce;
- (NSArray *(^)(BOOL (^)(id o)))reject;
@end

@interface NSArray (Underscore)
- (NSArray *(^)(id keypathOrClass))pluck;
- (NSArray *(^)(id arrayOrSetOrObject))without;
@end

@interface NSArray (Ruby)
- (NSArray *(^)(NSArray *other_array))concat;
- (NSArray *(^)(uint))first;  // @see last, slice
- (NSArray *(^)(uint))last;   // @see first, slice
- (NSString *(^)(NSString *))join;
- (NSArray *)reverse;
- (NSArray *(^)(int))rotate;
- (id)sample;
- (NSArray *)shuffle;
- (NSArray *(^)(int start, int length))slice;  // @see first, last
- (NSArray *)transpose;
- (NSArray *)uniq;
@end

@interface NSArray (YOLO)
- (BOOL)empty;
- (NSArray *(^)(id (^)(id o)))pmap;
- (NSSet *)set;
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

@interface NSDictionary (Underscore)
- (NSDictionary *(^)(id o, ...))extend;
@end

@interface NSDictionary (YOLO)
- (id (^)(id))get;
@end

@interface NSNumber (Ruby)
- (NSArray *(^)(int))upto;
@end

@interface NSString (YOLO)
- (NSArray *(^)(NSString *))split;
@end
