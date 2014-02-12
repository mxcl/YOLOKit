#import <Foundation/Foundation.h>

/**
 Documentated online: https://github.com/mxcl/YOLOKit/blob/master/README.markdown
**/

@interface NSArray (RubyEnumerable)
- (NSArray *(^)(id (^)(id o)))map;
- (NSArray *(^)(BOOL (^)(id o)))select;
- (NSArray *(^)(BOOL (^)(id o)))reject;
- (NSArray *(^)(void (^)(id o)))each;
- (NSArray *(^)(void (^)(id o, uint index)))eachWithIndex;
- (id(^)(id (^)(id memo, id obj)))reduce;
- (id(^)(id initial_memo, id (^)(id memo, id obj)))inject;
- (NSArray *)flatten;
- (id(^)(NSInteger (^)(id)))min;
- (id(^)(NSInteger (^)(id)))max;
- (id(^)(BOOL (^)(id o)))find;
- (NSUInteger (^)(id obj))indexOf;
- (NSArray *(^)(NSArray *(^)(id o)))flatMap;
- (NSDictionary *(^)(id (^)(id o)))groupBy;
- (NSArray *(^)(id (^)(id o)))sortBy;
- (NSArray *)sort;
@end

@interface NSArray (Underscore)
- (NSArray *(^)(id keypathOrClass))pluck;
@end

@interface NSArray (Ruby)
- (NSArray *)uniq;
- (NSArray *(^)(NSArray *other_array))concat;
- (NSArray *(^)(int start, int length))slice;
- (NSArray *(^)(uint))first;
- (NSArray *(^)(uint))last;
- (NSArray *)reverse;
- (NSString *)join;
- (NSArray *)transpose;
- (NSArray *)shuffle;
- (id)sample;
- (NSArray *(^)(int))rotate;
@end

@interface NSArray (YOLO)
- (NSArray *(^)(id arrayOrSetOrObject))without;
- (NSSet *)set;
- (NSArray *(^)(id (^)(id o)))pmap;
- (BOOL)empty;
@end

@interface NSMutableArray (YOLO)
- (id)pop;
- (NSMutableArray *(^)(id obj))push;
- (id)shift;
- (NSMutableArray *(^)(id obj))unshift;
@end

@interface NSSet (YOLO)
- (NSSet *)without:(NSSet *)set;
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
