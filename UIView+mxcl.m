#import "UIView+mxcl.h"

// http://stackoverflow.com/questions/751876
static void MBDumpViews(UIView* view, NSString *text, NSString *indent)
{
    Class cl = [view class];
    NSString *classDescription = [cl description];
    while ([cl superclass])
    {
        cl = [cl superclass];
        classDescription = [classDescription stringByAppendingFormat:@":%@", [cl description]];
    }

    if ([text compare:@""] == NSOrderedSame)
        NSLog(@"%@ %@", classDescription, NSStringFromCGRect(view.frame));
    else
        NSLog(@"%@ %@ %@", text, classDescription, NSStringFromCGRect(view.frame));

    for (NSUInteger i = 0; i < [view.subviews count]; i++)
    {
        UIView *subView = [view.subviews objectAtIndex:i];
        NSString *newIndent = [[NSString alloc] initWithFormat:@"  %@", indent];
        NSString *msg = [[NSString alloc] initWithFormat:@"%@%d:", newIndent, i];
        MBDumpViews(subView, msg, newIndent);
        [msg release];
        [newIndent release];
    }
}

@implementation UIView (mxcl)
- (NSArray *)allSubviews {
    NSMutableArray *views = [NSMutableArray array];
    for (UIView *view in self.subviews)
        [views addObjectsFromArray:[view allSubviews]];
    return views;
}
- (void)dumpViewTree {
    MBDumpViews(self, @"", @"");
}
@end
