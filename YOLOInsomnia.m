#ifndef TARGET_OS_IPHONE 

#import <IOKit/pwr_mgt/IOPMLib.h>
#import "YOLO.h"


@implementation YOLOInsomnia {
    IOPMAssertionID assertionID;
}

- (void)dealloc {
    [self off];
}

- (void)on {
    if (!assertionID) {
        IOPMAssertionCreateWithName(kIOPMAssertionTypeNoIdleSleep, kIOPMAssertionLevelOn, CFSTR("Making a rackit."), &assertionID);
    }
}

- (void)off {
    if (assertionID) {
        IOPMAssertionRelease(assertionID);
        assertionID = 0;
    }
}

@end

#endif
