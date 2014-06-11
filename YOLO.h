@import Foundation.NSArray;
@import Foundation.NSDictionary;
@import Foundation.NSSet;
@import Foundation.NSString;



@interface NSArray (YOLO)

#ifdef YOLO_ALL
/**
 Invokes the given block for each element in the receiver. Should the
 block return `NO`, the method immediately returns `NO`, ceasing
 enumeration. If all executions of the block return `YES`, `all`
 returns `YES`.

    BOOL rv = @[@1, @2, @3].all(^(id o){
        return [o intValue] > 0;
    });
    // rv => YES

    BOOL rv = @[@1, @2, @3].all(^(int d){
        return d < 3;
    });
    // rv => NO

 Instead of a block, you can pass a `Class` object.

    BOOL rv = @[@1, @2, @3].all(NSNumber.class);
    // rv => YES
*/
- (BOOL(^)(id blockOrClass))all;
#endif

#ifdef YOLO_ANY
/**
    BOOL rv = @[@1, @2, @3].any(^(id o){
        return [o intValue] == 3;
    });
    // rv => YES

 Instead of a block, you can pass a `Class` object.

    BOOL rv = @[@1, @2, @3].any(NSNumber.class);
    // rv => YES
*/
- (BOOL(^)(id blockOrClass))any;
#endif

#ifdef YOLO_CHUNK
/**
 Chunks the receiver into a new array of chunk-size arrays.

    id rv = @[@1, @2, @3, @4].chunk(2)
    // rv => @[@[@1, @2], @[@3, @4]]
*/
- (NSArray *(^)(NSUInteger))chunk;
#endif

#ifdef YOLO_CONCAT
/**
 Returns a new array that is the receiver with the given array
 concatenated to the end.

    id rv = @[@1, @2].concat(@[@3, @4]);
    // rv => @[@1, @2, @3, @4]
*/
- (NSArray *(^)(NSArray *other_array))concat;
#endif

#ifdef YOLO_DICT
/**
 Convert an array of key/value pairs into the logical dictionary.

    id rv = @[@[@1, @2], @[@3, @4]].dict
    // rv => @{@1: @2, @3: @4}

    id rv = @[@1, @2, @3, @4].chunk(2).dict
    // rv => @{@1: @2, @3: @4}

 If you have a flat array you can call `chunk(2)` before `dict`. It was
 decided not to allow flat arrays to be immediately converted as it can
 lead to bugs when your array is not in the shape you expect, and those
 sorts of errors occur more commonly with tools like YOLOKit since we
 allow easy array flattening.
*/
- (NSDictionary *)dict;
#endif

#ifdef YOLO_EACH
/**
 Calls the given block once for each element in the receiver, passing
 that element as the parameter.

    @[@1, @2, @3, @4].each(^(id n){
        NSLog(@"%@", n);
    });
    // => 1\n2\n3\n4\n

 `each` also supports two and three parameter versions:

    @[@4, @3, @2, @1].each(^(id n, int ii){
        NSLog(@"%d:%@", ii, n);
    });
    // => 0:1\n1:2\n2:3\n3:4\n

    @[@4, @3, @2, @1].each(^(id n, int ii, NSArray *array){
        //…
    });

    @[@4, @3, @2, @1].each(^(id n, NSNumber *index, NSArray *array){
        // and automagical conversion between int and NSNumber
    });
*/
- (NSArray *(^)(id block))each;
#endif

#ifdef YOLO_FIND
/**
 Passes each entry in the arry to the given block, returning the first
 element for which block is not `NO`. If no object matches, returns
 `nil`.

    id rv = @[@1, @2, @3, @4].find(^(id n){
        return [n isEqual:@3];
    });
    // rv => @3
*/
- (id(^)(id))find;
#endif

#ifdef YOLO_FIRST
/**
 Returns the first `n` elements of the receiver.

    id rv = @[@1, @2, @3, @4, @5, @6].first(2);
    // rv => @[@1, @2]

 PROTIP: YOLOKit is forgiving; if the array doesn’t have enough elements,
 `first` returns as many as it can.
*/
- (NSArray *(^)(NSUInteger))first;
#endif

#ifdef YOLO_FLATTEN
/**
 Returns a new, one-dimensional array that is a recursive flattening of
 the receiver.

    id rv = @[@[@1, @[@2]], @3, @[@4]].flatten
    // rv => @[@1, @2, @3, @4]
*/
- (NSArray *)flatten;
#endif

#ifdef YOLO_FLATMAP
/**
 Returns a new array with the concatenated results of running block once
 for every element in the receiver.

    id rv = @[@1, @2, @3, @4].flatMap(^(id n){
        return @[n, n];
    });
    // rv => @[@1, @1, @2, @2, @3, @3, @4, @4]

    id rv = @[@1, @2, @3, @4].flatMap(^(id n){
        return @[n, @[n]];
    });
    // rv => @[@1, @[@1], @2, @[@2], @3, @[@3], @4, @[@4]]

 PROTIP: Useful over vanilla map followed by a flatten because flatten is
 recursive, and you may want to preserve array relationships beyond the
 first level. Also, `flatMap` is technically more efficient.
*/
- (NSArray *(^)(NSArray *(^)(id o)))flatMap;
#endif

#ifdef YOLO_GROUPBY
/**
 Groups the collection by result of the given block.

    id rv = @[@1, @2, @3, @4].groupBy(^(NSNumber *n) {
        return @(n.intValue % 2);
    });
    // rv => @{@0: @[@1, @3], @1: @[@2, @4]}
*/
- (NSDictionary *(^)(id (^)(id o)))groupBy;
#endif

#ifdef YOLO_HAS
/**
    BOOL rv = @[@1, @2, @3].has(@2)
    // rv => YES

Short-hand for containsObject:. Provided because doing a map, then a
select and a few more chained dot-notations are commonly followed with
the need to then determine if a particular value is in the resulting
array, and then having to square bracket the whole chain is ugly.

We decided not to override any or find with the capability to take an
object rather than a block and instead add this method. Rest assured the
decision was careful. In the end has() seemed the choice that resulted in
the clearest code.

`has` was chosen over *contains* or *includes* because it is short and
clear.
*/
- (BOOL (^)(id o))has;
#endif

#ifdef YOLO_INDEXOF
/**
 Returns the index of the given object in the receiver or `NSNotFound` if
 the object was not found.

    uint rv = @[@1, @2, @3, @4].indexOf(@2);
    // rv => 1

 PROTIP: `NSNotFound` has the value `NSIntegerMax` so you don’t need to
 directly check for it, you can instead check if the returned value is
 less than the count of the receiver.
*/
- (NSUInteger (^)(id obj))indexOf;
#endif

#ifdef YOLO_INJECT
/**
 Combines all elements of the receiver by applying a binary operation.

    id rv = @[@1, @2, @3, @4].inject(@{}, ^(NSMutableDictionary *memo, NSNumber *n){
        memo[n] = @(n.intValue * n.intValue);
        return memo;
    });
    // rv => @{@1: @1, @2: @4, @3: @9, @4: @16}

 PROTIP: If you feed `inject` a non-mutable dictionary or array YOLOKit
 mutates it for your block, and then finally returns a non-mutable copy.

 @see -reject
*/
- (id(^)(id initial_memo, id (^)(id memo, id obj)))inject;
#endif

#ifdef YOLO_JOIN
/**
 Returns a string of all the receiver’s elements joined with the provided
 separator string.

    id rv = @[@1, @2, @3, @4].join(@",");
    // rv => @"1,2,3,4"

    id rv = @[@1, @2, @3, @4].join(@"");
    // rv => @"1234"

 PROTIP: `-description` is called on all objects before joining them.
*/
- (NSString *(^)(NSString *))join;
#endif

#ifdef YOLO_LAST
/**
 Returns the last `n` elements from receiver.

    id rv = @[@1, @2, @3, @4, @5, @6].last(2);
    // rv => @[@5, @6]

 PROTIP: If there are insufficient elements in the array, YOLOKit returns
 as many as it can.
*/
- (NSArray *(^)(NSUInteger))last;
#endif

#ifdef YOLO_MAP
/**
 Invokes the given block once for each element of self. Creates a new
 array containing the values returned by the block.

    id rv = @[@1, @2, @3, @4].map(^(NSNumber *n){
        return @(n.intValue * n.intValue);
    });
    // rv => @[@1, @4, @9, @16]

 If the given block returns nil, that element is skipped in the returned
 array.

 The given block can have up to three parameters, the first is an element
 in the array, the second that element’s index, and the third the array
 itself.

 The second parameter can be a primitive (eg. `int`), or an `NSNumber *`:

    @"YOLO".split(@"").map(^(NSString *letter, int index){
        //…
    });
*/
- (NSArray *(^)(id block))map;
#endif

#ifdef YOLO_MAX
/**
 Returns the element for which the given block returns the largest
 integer.

    id rv = @[@4, @2, @1, @3].max(^(NSNumber *n){
        return n.intValue;
    });
    // rv => @4

    id rv = @[@4, @2, @1, @3].max(^(NSNumber *n){
        return (n.intValue - 3) * (n.intValue - 3);
    });
    // rv => @1

 NOTE: currently you must return an integer, we plan to allow you to
 return whatever you like.
*/
- (id(^)(id))max;
#endif

#ifdef YOLO_MIN
/**
 Returns the element for which the given block returns the smallest
 integer.

    id rv = @[@4, @2, @1, @3].min(^(NSNumber *n){
        return n;
    });
    // rv => @1

 NOTE: currently you must return an integer, we plan to allow you to
 return whatever you like.
*/
- (id(^)(id))min;
#endif

#ifdef YOLO_NONE
/**
    BOOL rv = @[@1, @2, @3].none(^(id o){
        return [o intValue] > 4;
    });
    // rv => YES

 Instead of a block, you can pass a `Class` object.

    BOOL rv = @[@1, @2, @3].none(NSNumber.class);
    // rv => NO
*/
- (BOOL(^)(id blockOrClass))none;
#endif

#ifdef YOLO_PARTITION
/**
 Partitions the receiver into two arrays based on the boolean return
 value of the given block.

    id rv = @[@"A", @"B", @"AA"].partition(^(id s){
        return [s hasPrefix:@"A"];
    });
    //rv => @[@[@"A", @"AA"], @[@"B"]]
*/
- (NSArray *(^)(id blockReturningBool))partition;
#endif

#ifdef YOLO_PLUCK
/**
 Returns a new array that is the result of calling the given method on
 each element in the receiver.

    MKShape *rhombas = [MKShape new]; rhombas.title = @"rhombas";
    MKShape *ellipse = [MKShape new]; ellipse.title = @"ellipse";
    MKShape *hexagon = [MKShape new]; hexagon.title = @"hexagon";

    id rv = @[rhombas, ellipse, hexagon].pluck(@"title")
    // rv => @[@"rhombas", @"ellipse", @"hexagon"]

    id rv = @[rhombas, ellipse, hexagon].pluck(@"title.uppercaseString")
    // rv => @[@"RHOMBAS", @"ELLIPSE", @"HEXAGON"]

 NOTE: This is a convenience function for the common case of mapping
 (`-map`) an array to the result of a method call on each element.
*/
- (NSArray *(^)(NSString *keypath))pluck;
#endif

#ifdef YOLO_PMAP
/**
 Map, but run in parallel. Obviously: be thread safe in your block. The
 call waits for all elements to be processed. Typically not worth using
 unless you have large arrays since the overhead of
 thread-synchronization may be greater than the parallel savings
 otherwise.

 @see -map
*/
- (NSArray *(^)(id (^)(id o)))pmap;
#endif

#ifdef YOLO_REDUCE
/**
 Reduces the receiver to a single value.

 The usual example of reduce is to sum all values in an array.

    id rv = @[@1, @2, @3, @4].reduce(^(NSNumber *memo, NSNumber *obj){
        return @(memo.intValue + obj.intValue);
    });
    // rv => @10

 Generally `-inject` is more useful. Though, when appropriate, `reduce`
 is more elegant.

    // find the longest word
    id longest = @[@"cat", @"sheep", @"bear"].reduce(^(NSString *memo, NSString *word){
        return memo.length > word.length ? memo : word;
    });
    // longest => @"sheep"

 @param memo initialized to the first value in receiver, but on subsequent iterations is the value returned from the given block.
 @param obj the value for each element in the receiver, though never the first object.

 @see -inject
*/
- (id(^)(id (^)(id memo, id obj)))reduce;
#endif

#ifdef YOLO_SELECT
/**
 Returns a new array containing all elements for which the given block
 returns `NO`.

    id rv = @[@1, @2, @3, @4].reject(^(NSNumber *n){
        return n.intValue % 2 == 0;
    });
    // rv => @[@1, @3]

 Alternatively pass a `Class` object:

    id rv = @[@1, @"1", @{}].reject(NSNumber.class)
    // rv => @[@"1", @{}]

 @see -select
*/
- (NSArray *(^)(id blockOrClass))reject;
#endif

#ifdef YOLO_REVERSE
/**
 Returns a new array that is the receiver, reversed.

    id rv = @[@1, @2, @3, @4].reverse;
    // rv => @[@4, @3, @2, @1]

 NOTE: Did you know about `array.reverseEnumerator.allObjects`? We don’t
 use that in fact to save allocations, but you could do that on projects
 without YOLOKit.
*/
- (NSArray *)reverse;
#endif

#ifdef YOLO_ROTATE
/**
 Returns a new array rotated about the provided index.

    id rv = @[@1, @2, @3, @4, @5, @6].rotate(2);
    // rv => @[@3, @4, @5, @6, @1, @2]

    id rv = @[@1, @2, @3, @4, @5, @6].rotate(-2);
    // rv => @[@5, @6, @1, @2, @3, @4] 
*/
- (NSArray *(^)(NSInteger))rotate;
#endif

#ifdef YOLO_SAMPLE
/**
 Returns a random element from the receiver.
*/
- (id)sample;
#endif

#ifdef YOLO_SELECT
/**
 Returns a new array containing all elements for which the given block
 returns `YES`.

    id rv = @[@1, @2, @3, @4].select(^(NSNumber *n){
        return n.intValue % 2 == 0;
    });
    // rv => @[@2, @4]

 Alternatively pass a `Class` object:

    id rv = @[@1, @"1", @{}].select(NSString.class)
    // rv => @[@"1"]

 Convenient when searching for specifc subviews.

    self.view.subviews.select(UITextField.class);

 Though you may need an `allSubviews` pod.

 @see -reject
*/
- (NSArray *(^)(id blockOrClass))select;
#endif

#ifdef YOLO_SHUFFLE
/**
 Returns a new array that is shuffled.

 NOTE: Uses the Fisher–Yates shuffle algorithm.
*/
- (NSArray *)shuffle;
#endif

#ifdef YOLO_SKIP
/**
 Skips the first `n` elements and returns the rest of the array.

    id rv = @[@1, @2, @3, @4, @5, @6].skip(2);
    // rv => @[@3, @4, @5, @6]

 @see -first
 @see -last
 @see -slice
 @see -snip
*/
- (NSArray *(^)(NSUInteger numberToSkip))skip;
#endif

#ifdef YOLO_SLICE
/**
 Returns a subarray consisting of the given number of elements from the
 given starting index.

    id rv = @[@1, @2, @3, @4, @5, @6].slice(2, 2));
    // rv => @[@3, @4]

 PROTIP: Use slice instead of `first`, `last`, `skip` and `snip`… when
 you must. If you find yourself writing `array.slice(0, 4)` then consider
 `array.first(4)` instead: it’s more expressive, more explicit and
 shorter to boot.

 @see -first
 @see -last
 @see -skip
 @see -snip
*/
- (NSArray *(^)(NSUInteger start, NSUInteger length))slice;
#endif

#ifdef YOLO_SNIP
/**
 Snips the end off the array. Returns the receiver *without* the last `n`
 elements.

    id rv = @[@1, @2, @3, @4, @5, @6].snip(2);
    // rv => @[@1, @2, @3, @4]

 @see -first
 @see -last
 @see -skip
 @see -slice
*/
- (NSArray *(^)(NSUInteger numberToTrim))snip;
#endif

#ifdef YOLO_SORT
/**
 Returns the receiver, sorted.

    id rv = @[@2, @1, @3, @5, @4].sort;
    // rv => @[@1, @2, @3, @4, @5]

 We even try to handle mixed object types:

    id rv = @[@"20", @"1", @3, @5, @"4"].sort;
    // rv => @[@"1", @3, @"4", @5, @"20"]

 @see -sortBy

 PROTIP: Internally `sort` attempts to sort all objects using `-compare:`
 but if that fails, it calls `-description` on all objects and uses
 `-sortBy`.
*/
- (NSArray *)sort;

/**
 Sorts all objects using the return value of the given block as the
 sorting criteria.

    MKShape *rhombas = [MKShape new]; rhombas.title = @"rhombas";
    MKShape *ellipse = [MKShape new]; ellipse.title = @"ellipse";
    MKShape *hexagon = [MKShape new]; hexagon.title = @"hexagon";

    id rv = @[rhombas, ellipse, hexagon].sortBy(^(id shape){
        return [shape title];
    });
    // rv => @[ellipse, hexagon, rhombas]

    id rv = @[rhombas, ellipse, hexagon].sortBy(@"title")
    // rv => @[ellipse, hexagon, rhombas]

    id rv = @[
        @{@"name": @"frank", @"age": @32},
        @{@"name": @"frank", @"age": @31},
        @{@"name": @"bob", @"age": @54},
        @{@"name": @"zane", @"age": @1},
        @{@"name": @"frank", @"age": @12}
    ].sortBy(^(id o){
        return @[o[@"name"], o[@"age"]];
    });
    // rv => @[
    //     @{@"name": @"bob", @"age": @54},
    //     @{@"name": @"frank", @"age": @12},
    //     @{@"name": @"frank", @"age": @31},
    //     @{@"name": @"frank", @"age": @32},
    //     @{@"name": @"zane", @"age": @1}
    // ];

 PROTIP: You will need you to implement a compare: method for any custom
 objects you return.

 PROTIP: Returning an array from your block will sort the receiver so
 that the first object is the first sorting criteria, and the second
 object is the second sorting criteria, et cetera.
*/
- (NSArray *(^)(id blockOrKey))sortBy;
#endif

#ifdef YOLO_TRANSPOSE
/**
 Assumes that the receiver is an array of arrays and transposes the rows
 and columns.

    id rv = @[@[@1, @2, @3], @[@4, @5, @6]].transpose;
    // rv => @[@[@1, @4], @[@2, @5], @[@3, @6]]

 PROTIP: `transpose` is surprisingly useful, if you think laterally about
 your problem.
*/
- (NSArray *)transpose;
#endif

#ifdef YOLO_UNIQ
/**
 Returns a new array by removing duplicate values in the receiver.

    id rv = @[@1, @1, @2].uniq;
    // rv => @[@1, @2]

 PROTIP: Order is preserved.

 PROTIP: Equality is determined via `-hash` and `-isEqual:`.
*/
- (NSArray *)uniq;
#endif

#ifdef YOLO_WITHOUT
/**
 Returns a new array where objects in the given array are removed from
 the receiver.

    id rv = @[@1, @2, @3, @4, @5, @6].without(@2);
    // rv => @[@1, @3, @4, @5, @6]

    id rv = @[@1, @2, @3, @4, @5, @6].without(@[@2, @3]);
    // rv => @[@1, @4, @5, @6]
*/
- (NSArray *(^)(id arrayOrSetOrObject))without;
#endif

@end



@interface NSMutableArray (YOLO)
    
#ifdef YOLO_POP
/**
 Treats receiver like a stack and removes the last object, returning it.

    NSMutableArray *aa = [NSMutableArray new];
    id rv = aa.push(@1).push(@2).push(@3).pop()
    // rv => @3

 @see -push
*/
- (id)pop;
#endif

#ifdef YOLO_PUSH
/**
 Treats receiver like a stack and adds the given object to the end of the
 receiver.

    NSMutableArray *aa = [NSMutableArray new];
    id rv = aa.push(@1).push(@2).push(@3)
    // rv => @[@1, @2, @3]

 @see -pop
*/
- (NSMutableArray *(^)(id obj))push;
#endif

#ifdef YOLO_SHIFT
/**
 Removes the receiver’s first object and returns it.

    NSMutableArray *aa = [NSMutableArray new];
    id rv = aa.unshift(@1).unshift(@2).unshift(@3).shift();
    // rv => @3

 @see -unshift
*/
- (id)shift;
#endif

#ifdef YOLO_UNSHIFT
/**
 Inserts the given object at the front of receiver, moving all other
 objects in the receiver up one index.

    NSMutableArray *aa = [NSMutableArray new];
    id rv = aa.unshift(@1).unshift(@2).unshift(@3);
    // rv => @[@3, @2, @1]

 @see -shift
*/
- (NSMutableArray *(^)(id obj))unshift;
#endif

@end



@interface NSSet (YOLO)

#ifdef YOLO_EACH
/**
 @see NSArray’s -each
*/
- (NSSet *(^)(void (^)(id o)))each;
#endif

@end



@interface NSDictionary (YOLO)

#ifdef YOLO_ARRAY
/**
 Returns a new array of arrays of key, value pairs.

    id rv = @{@3: @"c", @1: @"a", @4: @"d", @2: @"b"}.array
    // rv = [@[@"3", @"c"], @[@1, @"a"], @[@4, @"d"], @[@2, @"b"]]
    // NOTE array order is undefined

    rv = rv.sort.transpose[1]
    // rv = [@"a", @"b", @"c", @"d"]
    // NOTE `rv.allValues.sort` would be more efficient
*/
- (NSArray *)array;
#endif

#ifdef YOLO_EXTEND
/**
 Returns a new, merged dictionary.

 @param higherPriorityDictionary The dictionary to merge with the
 receiver. If any keys conflict, the values in this dictionary take precendence.

    id rv = @{@1: @1, @2: @4}.extend(@{@1: @9, @10: @100});
    // rv => @{@1: @9, @2: @4, @10: @100}
*/
- (NSDictionary *(^)(NSDictionary *higherPriorityDictionary))extend;
#endif

#ifdef YOLO_GET
/**
 Returns the value associated with a given key.

    id rv = @{@1: @1, @2: @4}.get(@2);
    // rv => @4

 @see -objectForKey:
*/   
- (id (^)(id))get;
#endif

#ifdef YOLO_MAP
/**
 Invokes the given block once for each key, value pair in the receiver.
 Returns an array containing the values returned by the block.

    id rv = @{@1: @2, @2: @4, @3: @9}.map(^(id key, id obj){
        return @([key intValue] + [obj intValue]);
    }).sort;

    // rv = @[@3, @6, @12]
    // NOTE `sort` called illustratively because dictionary order is undefined.
*/
- (NSArray *(^)(id (^)(id key, id obj)))map;
#endif

#ifdef YOLO_PICK
/**
 Returns a new dictionary consisting of the given keys.
*/
- (NSDictionary *(^)(id o, ...))pick;
#endif

@end



@interface NSNumber (YOLO)

#ifdef YOLO_UPTO
/**
 Returns an array of consequentive numbers from receiver up to (and
 including) the given number.

    id rv = @1.upTo(6);
    // rv => @[@1, @2, @3, @4, @5, @6]
*/
- (NSArray *(^)(NSInteger))upTo;
#endif

@end



@interface NSString (YOLO)

#ifdef YOLO_SPLIT
/**
 Returns a new array of the strings in the receiver that are separated by
 the given separator.

    id rv = @"1,2,3,4,5,6".split(@",");
    // rv => @[@"1", @"2", @"3", @"4", @"5", @"6"]

 If you ask to separate by `@""` or `nil` you will get an array of the
 strings individual characters (as determined by `-substringWithRange`).

    id rv = @"123456".split(@"");
    // rv => @[@"1", @"2", @"3", @"4", @"5", @"6"]
*/
- (NSArray *(^)(NSString *))split;
#endif

@end
