
@implementation NSFileManager (YOLO)

- (NSString *)applicationSupportDirectory {
#ifdef TARGET_OS_IPHONE
    return [self documentsDirectory];
#else
    #error unimplemented
#endif
}

- (NSString *)documentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

@end
