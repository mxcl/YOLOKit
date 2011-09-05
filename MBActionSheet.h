#import <UIKit/UIKit.h>

@interface MBActionSheet : UIActionSheet <UIActionSheetDelegate>
+ (id)actionSheet;
@property (nonatomic, copy) void (^completionBlock)(NSUInteger index);
@end
