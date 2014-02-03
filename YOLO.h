@import Foundation;



@interface NSArray (RubyEnumerable)

/**
 A notable difference between our map and Ruby’s is if you return nil in your
 block, we skip that element. It’s as though compact is run afterwards. The
 reason for this is:
   1) nil cannot be added to NSArray;
   2) objc is awesome because calling a method on nil is not an error, so if we
      *could* add nil to arrays it would be the same effect as not having that
      element in (mostly).
   3) If we added NSNull instead you'd *continuously have to check for NSNull
      everywhere and we have made the decision that this would be super lame.
**/
- (NSArray *(^)(id (^)(id o)))map;

- (NSArray *(^)(BOOL (^)(id o)))select;
- (NSArray *(^)(BOOL (^)(id o)))reject;
- (NSArray *(^)(void (^)(id o)))each;
- (NSArray *(^)(void (^)(id o, uint index)))each_with_index;

/**
 Combines all elements into a single value. Memo starts as the first element in
 the array and each iteration is the value returned from your block
**/
- (id(^)(id (^)(id memo, id obj)))reduce;

/**
 Same as reduce, but you specify the initial memo, usually used to populate eg.
 an NSDictionary by providing an initial memo of @{} though with experience
 there are often better ways to do such things, like eg. group_by
**/
- (id(^)(id initial_memo, id (^)(id memo, id obj)))inject;

- (NSArray *)flatten;
- (id(^)(NSInteger (^)(id)))min;
- (id(^)(NSInteger (^)(id)))max;
- (id(^)(BOOL (^)(id o)))find;
- (NSUInteger (^)(id obj))index_of;
- (NSArray *(^)(NSArray *(^)(id o)))flat_map;
- (NSDictionary *(^)(id (^)(id o)))group_by;

@end


@interface NSArray (Underscore)
/**
 Map for the specified keypath, uses valueForKeyPath so you can specify
 multiple levels of key. Check Apple’s docs if you are unfamiliar.
**/
- (NSArray *(^)(NSString *keypath))pluck;
@end



@interface NSArray (Ruby)

- (NSArray *)uniq;  // like Ruby, preserves sort order

- (NSArray *(^)(NSArray *other_array))concat;

/**
 Ruby allows ranges to be passed to slice, but since we have no equivalent I
 have made it so length (as well as start) can be negative, in that case length
 is no longer length, but end-position.
 **/
- (NSArray *(^)(int start, int length))slice;

- (NSArray *(^)(NSUInteger))first;
- (NSArray *(^)(NSUInteger))drop;
- (NSArray *(^)(NSUInteger))last;

/**
 NOTE we didn't implement take as its name is confusing and it behaves the exact
 same as first().
**/

@end



@interface NSArray (YOLO)

- (NSArray *(^)(id arrayOrSetOrClass))without;
- (NSSet *)set;

@end



@interface NSMutableArray (YOLO)

- (id)pop;
- (NSMutableArray *(^)(id obj))add;

@end



@interface NSSet (YOLO)

- (NSSet *)without:(NSSet *)set;

@end



@interface NSSet (RubyEnumerable)

- (NSSet *(^)(void (^)(id o)))each;

@end



@interface NSDictionary (Underscore)

/** two forms supported, single argument which is a dictionary
  * or *two* arguments, a key and value */
- (NSDictionary *(^)(id o, ...))extend;

@end
