#import <Foundation/NSString.h>

@interface NSString (YOLOSplit)

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

@end
