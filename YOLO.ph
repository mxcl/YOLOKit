#import "YOLO.h"

@import Foundation.NSMethodSignature;
extern NSMethodSignature *YOLOMS(id);

// Disabling this warning because we split our YOLO category
// across many `.m` files and thus in every file clang warns
// that we didn’t implement the entire category. Adding the
// warning to our Podspec prevented the Podspec from validating

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"
