@import UIKit;


@interface YOLOActionSheet : UIActionSheet <UIActionSheetDelegate>
+ (instancetype)actionSheet;
@property (nonatomic, copy) void (^completionBlock)(NSUInteger index);
@end


#ifndef TARGET_OS_IPHONE
@interface YOLOInsomnia : NSObject
- (void)on;
- (void)off;
@end
#endif


#ifdef YOLO_SQLITE
@interface YOLOSQLite : NSObject
- (instancetype)initWithPath:(id)path;
- (NSArray *)exec:(id)sql;
- (id)lastInsertRowID;

@property (nonatomic) BOOL throwErrors;
@end
#endif


@interface NSString (YOLOSQLite)
- (instancetype)sqlite3_escape;
@end


/** Save your data in the background on a serial queue.
  * When you add your job, any existing jobs in the queue are canceled. This is
    the main point of this class, that is: to avoid resource starvation because
    of situations where your save function is called way more than you expected.
  * NOTE that obviously the block is called in the background, so: be thread-safe.
  * NOTE you probably want to waitUntilAllOperationsAreFinished in your class’s
         dealloc selector.
  */

@interface YOLOSaveQueue : NSOperationQueue

// relative paths will be made absolute relative to ApplicationSupport
- (instancetype)initWithSaveFilename:(NSString *)path;

// return an NSData object in your block
- (void)addOperationWithBlock:(NSData *(^)(void))returnTheDataToSave;

@property (nonatomic, readonly) NSString *path;
@end


@interface NSArray (RubyEnumerable)
- (NSArray *)map:(id (^)(id o))block;
- (NSArray *)select:(BOOL (^)(id o))block;
- (NSArray *)reject:(BOOL (^)(id o))block;
- (id)find:(BOOL (^)(id o))block;
- (NSArray *)flatten;
- (id)min:(NSInteger (^)(id o))block;
- (id)inject:(id (^)(id memo, id obj))block;
- (id)inject:(id)initialMemo block:(id (^)(id memo, id obj))block;
@end


@interface NSArray (YOLO)
- (NSArray *)shuffledArray; // Do not use this if there a chance that all
							// values are equal or if most values are equal
- (NSData *)JSONData;
- (NSString *)JSONString;
- (NSArray *)uniq;          // like Ruby, preserves sort order
@end


@interface NSMutableArray (YOLO)
- (id)pop;
@end


@interface NSDictionary (YOLO)
- (NSString *)massagedStringForKey:(id)key; // returns nil if not a string or
											// if string length is zero after
											// whitespace trim on both ends
- (NSData *)JSONData;
- (NSString *)JSONString;
@end


@interface NSFileManager (YOLO)
- (NSString *)applicationSupportDirectory;
- (NSString *)documentsDirectory;
@end


@interface NSNumber (YOLO)
- (NSString *)localizedString;
@end


@interface NSObject (YOLO)
+ (id)objectWithJSONData:(NSData *)json;
+ (id)objectWithJSONString:(NSString *)json;
@end


@interface NSObject (PListCompliant)
- (id)plistCompliantObject; // PLISTs cannot contains NULL, so we remove those
@end


@interface NSString (YOLO)
- (NSNumber *)wordCount;
- (NSRange)range;
- (NSString *)strippedString;
- (NSString *)chuzzle;        // returns nil if trimmed string is empty
								// FYI calling chuzzle on nil returns nil too!
@end


@interface UIAlertView (YOLO)
// because 50% of the time I forget to call show and then you have a likely untested branch where you don't show the user an error message
// NOOP if error == nil (for convenience)
+ (void)showAlertViewForError:(NSError *)error title:(NSString *)title;
@end


@interface UIColor (YOLO)
- (BOOL)dark;  // is this image dark when viewed by the human eye?
+ (instancetype)randomColor;
@end


#define UIColorFromRGB(rgbValue) \
    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                    green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
                     blue:((float)(rgbValue & 0xFF))/255.0 \
                    alpha:1.0]


@interface UIImage (YOLO)
- (UIColor *)color;  // the pixel-averaged color of this image
- (UIStatusBarStyle)preferredStatusBarStyle;
+ (UIImage *)imageWithColor:(UIColor *)color;
@end


@interface UIView (YOLO)
- (NSArray *)allSubviews;
@end


void UIViewDumpSubviewTree(UIView *view);
void NSObjectDumpSelectors(NSObject *o);
