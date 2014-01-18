#import "YOLO.h"


@implementation YOLOActionSheet

+ (instancetype)actionSheet {
    YOLOActionSheet *sheet = [self new];
    sheet.delegate = sheet;
    return sheet;
}

- (void)actionSheet:(YOLOActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    _completionBlock(buttonIndex);
    _completionBlock = nil;
}

@end
