typedef uint32_t IOPMAssertionID;

@interface MBInsomnia : NSObject {
    IOPMAssertionID assertionID;
}
- (void)on;
- (void)off;
@end
