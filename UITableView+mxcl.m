#import "UITableView+mxcl.h"

@implementation UITableView (mxcl)
- (UITableViewCell *)dequeueReusableCell {
    return [self dequeueReusableCellWithStyle:UITableViewCellStyleDefault];
}

- (UITableViewCell *)dequeueReusableCellWithStyle:(UITableViewCellStyle)style {
    #define CELLID @"mxcl_UITableViewCellID"
    return [self dequeueReusableCellWithIdentifier:CELLID]
        ?: [[UITableViewCell alloc] initWithStyle:style reuseIdentifier:CELLID];
    #undef CELLID
}
@end
