#import <Foundation/Foundation.h>
#import "MBWebSocketServer.h"
#import <sqlite3.h>


@interface MBSQLite : NSObject {
    sqlite3 *db;
}
- (id)initWithPath:(id)path;
- (NSArray *)exec:(id)sql;
- (id)lastInsertRowID;

@property (nonatomic) BOOL throwErrors;
@end


@interface NSString (MBSQLite)
- (id)sqlite3_escape;
@end