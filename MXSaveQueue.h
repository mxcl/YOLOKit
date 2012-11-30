#import <Foundation/Foundation.h>

/** Save your data in the background on a serial queue.
  * When you add your job, any existing jobs in the queue are canceled. This is
    the main point of this class, that is: to avoid resource starvation because
    of situations where your save function is called way more than you expected.
  * NOTE that obviously the block is called in the background, so: be thread-safe.
  * NOTE you probably want to waitUntilAllOperationsAreFinished in your class’s
         dealloc selector.
  */

@interface MXSaveQueue : NSOperationQueue

// relative paths will be made absolute relative to ApplicationSupport
- (id)initWithSaveFilename:(NSString *)path;

// return an NSData object in your block
- (void)addOperationWithBlock:(NSData *(^)(void))returnTheDataToSave;

@property (nonatomic, readonly) NSString *path;
@end
