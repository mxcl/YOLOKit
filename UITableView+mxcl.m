#import "UITableView+mxcl.h"

@implementation UITableView (mxcl)
- (UITableViewCell *)dequeueReusableCell {
    #define CELLID @"mxcl_UITableViewCellID"
    return [self dequeueReusableCellWithIdentifier:CELLID]
        ?: [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLID] autorelease];
    #undef CELLID
}
@end
