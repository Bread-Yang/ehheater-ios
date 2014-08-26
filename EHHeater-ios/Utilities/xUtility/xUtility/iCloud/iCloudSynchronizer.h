//
//  iCloudSynchronizier.h
//  xUtility
//
//  Created by apple on 12-5-29.
//  Copyright (c) 2012年 Xtremeprog.com. All rights reserved.
//

typedef enum{
    UPLOAD_FAILED = 0,
    UNEXIT_SANDBOX_UPLOAD_FAILED = 1,
    UPLOAD_SUCCESS = 2,
    EXIST_UPLOAD_SUCCESS = 3
} iCloudUploadResult;

typedef enum{
    DOWNLOAD_FAILED = 0,
    DOWNLOAD_SUCCESS = 1
} iCloudDownloadResult;

typedef enum{
    SYN_NOTHING_ICLOUD = 0,
    SYN_TO_ICLOUD = 1,
    SYN_FROM_ICLOUD = 2,
    SYN_ICLOUD_NOT_ACTIVE = 3
} iCloudType;

typedef enum{
    VERSION_ICLOUD_NO_VERSION = 1,
    VERSION_LOCAL_NO_VERSION = 2,
    VERSION_NEED_SYN_FROM_ICLOUD = 3,
    VERSION_CAN_SYN_TO_ICLOUD = 4,
    VERSION_ICLOUD_NOT_ACTIVE = 5,
    VERSION_NO_EFFECT_VERSION = 6
} iCloudVersion;

#define SYNCHROINZE_DOWNLOAD_UNZIP_FINISH @"SYNCHROINZE_DOWNLOAD_UNZIP_FINISH"

#define ICLOUD_CURRENT_VERSION @"SQLversion"
#define ICLOUD_CURRENT_VERSION_PLIST @"SQLversion.plist"

#define ICLOUD_VERSION_NAME @"version_syn.zip"
#define ICLOUD_ZIP_NAME @"iClamp.sqlite"

#define CONNECT_DATA_NAME @"connect_data"

#define NOTIFICATION_DOWNLODE_SUCCESS @"NOTIFICATION_DOWNLODE_SUCCESS"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol iCloudSynchronizerDelegate;
@interface iCloudSynchronizer : NSObject {
    
    id<iCloudSynchronizerDelegate> _delegate;
    
    NSMutableArray *engoreFiles;
    NSString *recordSynchronizedFilesFileName;
    NSString *currentDirectory;
    NSString *currentDocumentDirectory;
    
    NSInteger currentSynType;
}

@property(nonatomic,assign) id<iCloudSynchronizerDelegate> delegate;

+ (id)synchronizer;

- (void)setCurrentDirectory:(NSString *)directoryName;

- (NSString *)sandboxPath:(NSString *)fileName;

- (NSData *)sandboxData:(NSString *)fileName;

- (BOOL)saveToSandbox:(NSData *)data fileName:(NSString *)fileName;

- (BOOL)removeFromSandbox:(NSString *)fileName;

- (void)clearSandbox;

- (NSURL *)iCloudURL:(NSString *)fileName;

- (void)startSynchronizeData;

- (BOOL)synchronizeDataToiCloud;

- (BOOL)synchronizeDataFromiCloud;

- (BOOL)uploadDataToiCloud:(NSString *)fileName;

- (NSMutableDictionary *)downloadData:(NSString *)fileName;

- (NSData *)downloadDataFromiCloud:(NSString *)fileName;

- (NSMutableArray *)listAllFiles;

- (NSString *)packageAllFiles;

- (void)unPackageZipFile:(NSData *)data;

- (void)createFolderInCloud:(NSString *)folderName;

- (void)addEngoreFileName:(NSString *)engoreFileName;

- (void)createVersion:(NSInteger)currentVersion;

- (iCloudVersion)checkVersion;

- (BOOL)downloadFileIfNotAvailable:(NSURL *)file;

- (BOOL)checkiCloud;

- (NSInteger)localVersion;

- (NSInteger)iCloudVersion;

- (void)synchronizeVersion:(BOOL)uploadOrDownload;

//[[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(iCloudDownSuccessed) name:NOTIFICATION_DOWNLODE_SUCCESS object:nil];
//[[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_DOWNLODE_SUCCESS object:nil];


@end

@protocol iCloudSynchronizerDelegate <NSObject>

@optional

- (void)iCloud:(iCloudSynchronizer *)synchronizer synchronizeFromiCloud:(iCloudDownloadResult)downloadResult data:(NSData *)data;
- (void)iCloud:(iCloudSynchronizer *)synchronizer downloadFromiCloud:(iCloudDownloadResult)downloadResult data:(NSData *)data;

- (void)iCloud:(iCloudSynchronizer *)synchronizer iCloudActive:(BOOL)active;

- (void)iCloud:(iCloudSynchronizer *)synchronizer synchronizeToiCloud:(iCloudUploadResult)uploadResult;
- (void)iCloud:(iCloudSynchronizer *)synchronizer uploadToiCloud:(iCloudUploadResult)uploadResult;

- (void)iCloud:(iCloudSynchronizer *)synchronizer iCloudType:(iCloudType)iCloudType object:(id)object;

@end
