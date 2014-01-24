@import Foundation;


@interface NSArray (RubyEnumerable)

- (NSArray *(^)(id (^)(id o)))map;
- (NSArray *(^)(BOOL (^)(id o)))select;
- (NSArray *(^)(BOOL (^)(id o)))reject;
- (NSArray *(^)(NSString *key))pick;  // uses [foo valueForKeyPath];
- (NSArray *(^)(void (^)(id o)))each;
- (NSArray *(^)(id (^)(id memo, id obj)))inject;
- (NSArray *)flatten;
- (NSArray *(^)(NSInteger (^)(id o)))min;
- (NSArray *(^)(NSInteger (^)(id o)))max;

- (NSArray *)map:(id (^)(id o))block;
- (NSArray *)select:(BOOL (^)(id o))block;
- (NSArray *)reject:(BOOL (^)(id o))block;
- (id)find:(BOOL (^)(id o))block;
- (id)min:(NSInteger (^)(id o))block;
- (id)max:(NSInteger (^)(id o))block;
- (id)inject:(id (^)(id memo, id obj))block;
- (id)inject:(id)initialMemo block:(id (^)(id memo, id obj))block;

@end


@interface NSArray (Ruby)
// Ruby allows ranges to be passed to slice, but since we have no equivalent
// I have made it so length (as well as start) can be negative, in that case
// length is no longer length, but end-position.
- (NSArray *(^)(int start, int length))slice;
- (NSArray *)uniq;  // like Ruby, preserves sort order
@end


@interface NSArray (YOLO)

- (NSArray *(^)(void (^)(id arrayOrSet)))without;

- (NSArray *)shuffledArray; // Do not use this if there a chance that all
							// values are equal or if most values are equal
- (NSData *)JSONData;
- (NSString *)JSONString;

- (NSSet *)set;

@end


@interface NSMutableArray (YOLO)
- (id)pop;
@end


@interface NSSet (YOLO)
- (NSSet *)without:(NSSet *)set;
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
- (NSString *)localizedString;  // eg. 10,123 (with commas/whatever per locale)
@end


@interface NSObject (PListCompliant)
- (id)plistCompliantObject; // When you are trying to write dictionaries or
							// arrays to PLISTs using writeToFile type methods
							// NULLs throw exceptions, and if you have JSON data
							// then you will have nulls, so this sanitizes the
							// objects so you won't get a crash
@end


void NSObjectDumpSelectors(NSObject *o);


@interface NSString (YOLO)
- (NSRange)range;      // convenience
- (NSString *)strip;   // convenience
- (NSString *)chuzzle; // returns stripped string unless stripped string has
					   // zero length, if so it returns nil. Stop putting empty
					   // strings in the user's face! Short-circuit off your
					   // chuzzled strings with the ?: compact ternary operator!
@end


#if TARGET_OS_IPHONE
@import UIKit;

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
+ (UIImage *)imageWithColor:(UIColor *)color; // A 1x1 image of that color
- (UIImage *)croppedImage:(CGRect)cropRect;
- (UIImage *)imageTintedWithColor:(UIColor *)color;
@end


@interface UIView (YOLO)
- (NSArray *)allSubviews;
@end


void UIViewDumpSubviewTree(UIView *view);


/** Let’s use blocks more */
@interface YOLOActionSheet : UIActionSheet <UIActionSheetDelegate>
+ (instancetype)actionSheet;
@property (nonatomic, copy) void (^completionBlock)(NSUInteger index);
@end
#endif


#ifndef TARGET_OS_IPHONE
// turn on and your Mac app will prevent sleep (but not screen sleep)
@interface YOLOInsomnia : NSObject
- (void)on;
- (void)off;
@end
#endif


#ifdef __YOSQLO__
// You Only SQLive Once
@interface YOSQLO : NSObject
- (instancetype)initWithPath:(id)path;
- (NSArray *)exec:(id)sql;
- (id)lastInsertRowID;

@property (nonatomic) BOOL throwErrors;
@end

@interface NSString (YOSQLO)
- (instancetype)sqlite3_escape;
@end
#endif


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
