#import <Foundation/NSArray.h>

@interface NSArray (YOLOSelect)

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

@end
