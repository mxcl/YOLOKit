#import <IOKit/pwr_mgt/IOPMLib.h>
#import "MBInsomnia.h"

@implementation MBInsomnia

- (void)dealloc {
    [self off];
}

- (void)on {
    if (!assertionID) {
        IOPMAssertionCreateWithName(kIOPMAssertionTypeNoDisplaySleep, kIOPMAssertionLevelOn, CFSTR("Making a rackit."), &assertionID);
    }
}

- (void)off {
    if (assertionID) {
        IOPMAssertionRelease(assertionID);
        assertionID = 0;
    }
}

@end
