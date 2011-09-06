#import <UIKit/UIKit.h>

@interface UIAlertView (mxcl)
// if error is nil, nothing happens, thus you can avoid the `if (error)` if you like
+ (void)showAlertViewForError:(NSError *)error title:(NSString *)title;
@end
