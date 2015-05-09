#import <Foundation/NSArray.h>

@interface NSArray (YOLOPluck)

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

@end
