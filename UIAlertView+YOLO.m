#import "YOLO.h"


@implementation UIAlertView (YOLO)

+ (void)showAlertViewForError:(NSError *)error title:(NSString *)title
{
    if (error) {
        NSString *msg = [error localizedDescription];
        if (error.localizedFailureReason) {
            msg = [NSString stringWithFormat:@"%@. %@", msg, error.localizedFailureReason];
        }

        UIAlertView *alertView = [[self alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"That Sucks!" otherButtonTitles:nil];
        [alertView show];
    }
}

@end
