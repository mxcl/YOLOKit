#import "MBActionSheet.h"

@implementation MBActionSheet
@synthesize completionBlock;

+ (id)actionSheet {
    MBActionSheet *sheet = [MBActionSheet new];
    sheet.delegate = sheet;
    return sheet
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    completionBlock(buttonIndex);
    self.completionBlock = nil;
}
@end
