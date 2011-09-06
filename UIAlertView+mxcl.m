#import "UIAlertView+mxcl.h"

@implementation UIAlertView (mxcl)
+ (void)showAlertViewForError:(NSError *)error title:(NSString *)title
{
    if (error) {
        NSString *msg = [error localizedDescription];
        if (error.localizedFailureReason) {
            msg = [NSString stringWithFormat:@"%@. %@", msg, error.localizedFailureReason];
        }

        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                            message:msg
                                                           delegate:nil
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
}
@end
