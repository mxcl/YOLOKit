@import Foundation.NSArray;
@import Foundation.NSDictionary;
@import Foundation.NSSet;
@import Foundation.NSString;



@interface NSArray (YOLO)

#ifdef YOLO_ALL
- (BOOL(^)(id blockOrClass))all;
#endif

#ifdef YOLO_ANY
- (BOOL(^)(id))any;
#endif

#ifdef YOLO_CHUNK
- (NSArray *(^)(NSUInteger))chunk;
#endif

#ifdef YOLO_CONCAT
- (NSArray *(^)(NSArray *other_array))concat;
#endif

#ifdef YOLO_DICT
- (NSDictionary *)dict;
#endif

#ifdef YOLO_EACH
- (NSArray *(^)(id block))each;
#endif

#ifdef YOLO_FIND
- (id(^)(id))find;
#endif

#ifdef YOLO_FIRST
- (NSArray *(^)(NSUInteger))first;
#endif

#ifdef YOLO_FLATTEN
- (NSArray *)flatten;
#endif

#ifdef YOLO_FLAT_MAP
- (NSArray *(^)(NSArray *(^)(id o)))flatMap;
#endif

#ifdef YOLO_GROUP_BY
- (NSDictionary *(^)(id (^)(id o)))groupBy;
#endif

#ifdef YOLO_HAS
- (BOOL (^)(id o))has;
#endif

#ifdef YOLO_INDEX_OF
- (NSUInteger (^)(id obj))indexOf;
#endif

#ifdef YOLO_INJECT
- (id(^)(id initial_memo, id (^)(id memo, id obj)))inject;
#endif

#ifdef YOLO_JOIN
- (NSString *(^)(NSString *))join;
#endif

#ifdef YOLO_LAST
- (NSArray *(^)(NSUInteger))last;
#endif

#ifdef YOLO_MAP
- (NSArray *(^)(id block))map;
#endif

#ifdef YOLO_MAX
- (id(^)(id))max;
#endif

#ifdef YOLO_MIN
- (id(^)(id))min;
#endif

#ifdef YOLO_NONE
- (BOOL(^)(id blockOrClass))none;
#endif

#ifdef YOLO_PARTITION
- (NSArray *(^)(id blockReturningBool))partition;
#endif

#ifdef YOLO_PLUCK
- (NSArray *(^)(NSString *keypath))pluck;
#endif

#ifdef YOLO_PMAP
- (NSArray *(^)(id (^)(id o)))pmap;
#endif

#ifdef YOLO_REDUCE
- (id(^)(id (^)(id memo, id obj)))reduce;
#endif

#ifdef YOLO_SELECT
- (NSArray *(^)(id blockOrClass))reject;
#endif

#ifdef YOLO_REVERSE
- (NSArray *)reverse;
#endif

#ifdef YOLO_ROTATE
- (NSArray *(^)(NSInteger))rotate;
#endif

#ifdef YOLO_SAMPLE
- (id)sample;
#endif

#ifdef YOLO_SELECT
- (NSArray *(^)(id blockOrClass))select;
#endif

#ifdef YOLO_SHUFFLE
- (NSArray *)shuffle;
#endif

#ifdef YOLO_SKIP
- (NSArray *(^)(NSUInteger numberToSkip))skip;
#endif

#ifdef YOLO_SLICE
- (NSArray *(^)(NSUInteger start, NSUInteger length))slice;
#endif

#ifdef YOLO_SNIP
- (NSArray *(^)(NSUInteger numberToTrim))snip;
#endif

#ifdef YOLO_SORT
- (NSArray *)sort;
- (NSArray *(^)(id blockOrKey))sortBy;
#endif

#ifdef YOLO_TRANSPOSE
- (NSArray *)transpose;
#endif

#ifdef YOLO_UNIQ
- (NSArray *)uniq;
#endif

#ifdef YOLO_WITHOUT
- (NSArray *(^)(id arrayOrSetOrObject))without;
#endif

@end



@interface NSMutableArray (YOLO)
    
#ifdef YOLO_POP
- (id)pop;
#endif

#ifdef YOLO_PUSH
- (NSMutableArray *(^)(id obj))push;
#endif

#ifdef YOLO_SHIFT
- (id)shift;
#endif

#ifdef YOLO_UNSHIFT
- (NSMutableArray *(^)(id obj))unshift;
#endif

@end



@interface NSSet (YOLO)

#ifdef YOLO_EACH
- (NSSet *(^)(void (^)(id o)))each;
#endif

@end



@interface NSDictionary (YOLO)

#ifdef YOLO_ARRAY
- (NSArray *)array;
#endif

#ifdef YOLO_EXTEND
- (NSDictionary *(^)(id o, ...))extend;
#endif

#ifdef YOLO_GET
- (id (^)(id))get;
#endif

#ifdef YOLO_MAP
- (NSArray *(^)(id (^)(id key, id obj)))map;
#endif

#ifdef YOLO_PICK
- (NSDictionary *(^)(id o, ...))pick;
#endif

@end



@interface NSNumber (YOLO)

#ifdef YOLO_UP_TO
- (NSArray *(^)(NSInteger))upTo;
#endif

@end



@interface NSString (YOLO)

#ifdef YOLO_SPLIT
- (NSArray *(^)(NSString *))split;
#endif

@end
