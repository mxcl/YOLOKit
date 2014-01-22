#import "YOLO.h"
#import <sqlite3.h>

static int sqlite3_exec_callback(void *userdata, int argc, char **argv, char **column) {
    id aa = (__bridge NSMutableArray *)userdata;
    while (argc--)
        [aa insertObject:@(argv[argc]) atIndex:0];
    return SQLITE_OK;
}



@implementation YOSQLO {
    sqlite3 *db;
}

- (id)init {
    id path = [[self class] performSelector:@selector(path)]
           ?: [[NSFileManager defaultManager].applicationSupportDirectory stringByAppendingPathComponent:@"sqlite.db"];
    return [self initWithPath:path];
}

- (id)initWithPath:(id)path {
    if (sqlite3_open([path UTF8String], &db) != SQLITE_OK) {
        NSLog(@"Could not open DB");
        return nil;
    }
    return self;
}

- (NSArray *)exec:(id)sql {
    if (!db)
        return nil;
    
    NSMutableArray *results = [NSMutableArray array];
    char *err = NULL;
    if (sqlite3_exec(db, [sql UTF8String], sqlite3_exec_callback, (__bridge void *)results, &err) != SQLITE_OK) {
        id nserr = @(err);
        sqlite3_free(err);
        if (!_throwErrors)
            NSLog(@"SQLite3 Error: %@", nserr);
        else
            @throw nserr;
        return nil;
    }
    return results;
}

- (void)dealloc {
    if (db)
        sqlite3_close(db);
    db = NULL;
}

- (id)lastInsertRowID {
    return @(sqlite3_last_insert_rowid(db));
}

@end



@implementation NSString (YOSQLO)

- (instancetype)sqlite3_escape {
    return [self stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
}

@end
