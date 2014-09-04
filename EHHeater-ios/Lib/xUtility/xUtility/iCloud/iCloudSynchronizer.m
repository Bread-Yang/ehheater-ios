//
//  iCloudSynchronizier.m
//  xUtility
//
//  Created by apple on 12-5-29.
//  Copyright (c) 2012年 Xtremeprog.com. All rights reserved.
//

#import "iCloudSynchronizer.h"
#import "ZipFile.h"
#import "ZipException.h"
#import "FileInZipInfo.h"
#import "ZipWriteStream.h"
#import "ZipReadStream.h"

static iCloudSynchronizer *instance;
@implementation iCloudSynchronizer

@synthesize delegate = _delegate;

#pragma mark - Private

- (NSDictionary *)dictionaryWithContentsOfData:(NSData *)data {
    CFPropertyListRef list = CFPropertyListCreateFromXMLData(kCFAllocatorDefault, (CFDataRef)data, kCFPropertyListImmutable, NULL);
    if(list == nil) return nil;
    if ([(id)list isKindOfClass:[NSDictionary class]]) {
        return [(NSDictionary *)list autorelease];
    }
    else {
        CFRelease(list);
        return nil;
    }
}

- (BOOL)downloadFileIfNotAvailable:(NSURL *)file {
    NSNumber *isIniCloud = nil;
    if ([file getResourceValue:&isIniCloud forKey:NSURLIsUbiquitousItemKey error:nil]) {
        if ([isIniCloud boolValue]) {
            NSNumber *isDownloaded = nil;
            if ([file getResourceValue:&isDownloaded forKey:NSURLUbiquitousItemIsDownloadedKey error:nil]) {
                if ([isDownloaded boolValue])
                    return YES;
                
                NSFileManager *fm = [NSFileManager defaultManager];
                if (![fm startDownloadingUbiquitousItemAtURL:file error:nil]) {
                    return NO;
                }
                return YES;
            }
        }
    }
    return NO;
}

- (void)removeFromSandboxAfaterDelay:(id)data {
    [instance performSelector:@selector(removeFromSandbox:) withObject:data afterDelay:1.0f];
}

- (void)unPackageZipFileAfaterDelay:(id)data {
    [instance performSelector:@selector(unPackageZipFile:) withObject:data afterDelay:1.0f];
}

- (void)invokeiCloudActiveDelegate:(NSNumber *)active {
    if(self.delegate && [self.delegate respondsToSelector:@selector(iCloud:iCloudActive:)]){
        [self.delegate iCloud:self iCloudActive:[active boolValue]];
    }
}


#pragma mark - Private

- (void)downloadSuccessThenUnzipSuccess:(NSNotification *)notification {
    NSData *data = notification.object;
    if(data){
        if(self.delegate && [self.delegate respondsToSelector:@selector(iCloud:synchronizeFromiCloud:data:)]){
            [self.delegate iCloud:self synchronizeFromiCloud:DOWNLOAD_SUCCESS data:data];
        }
    }else{
        if(self.delegate && [self.delegate respondsToSelector:@selector(iCloud:synchronizeFromiCloud:data:)]){
            [self.delegate iCloud:self synchronizeFromiCloud:DOWNLOAD_FAILED data:data];
        }
    }
}

#pragma mark - Public

+ (id)synchronizer {
    //    return nil;
    if(!instance){
        instance = [[iCloudSynchronizer alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:instance selector:@selector(downloadSuccessThenUnzipSuccess:) name:SYNCHROINZE_DOWNLOAD_UNZIP_FINISH object:nil];
    }
    return instance;
}

- (void)setCurrentDirectory:(NSString *)directoryName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    currentDocumentDirectory = [[[paths objectAtIndex:0] stringByAppendingPathComponent:directoryName] copy];
    currentDirectory = [directoryName copy];
    [[NSFileManager defaultManager] createDirectoryAtPath:currentDocumentDirectory withIntermediateDirectories:YES attributes:nil error:nil];
}

- (NSString *)sandboxPath:(NSString *)fileName {
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if(currentDocumentDirectory){
        NSString *path = [NSString stringWithFormat:@"%@/%@",currentDocumentDirectory,fileName];
        return path;
    }
    NSString *path = [NSString stringWithFormat:@"%@/%@",[searchPaths objectAtIndex:0],fileName];
    return path;
}

- (NSData *)sandboxData:(NSString *)fileName {
    NSString *path = [self sandboxPath:fileName];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return data;
}

- (BOOL)saveToSandbox:(NSData *)data fileName:(NSString *)fileName {
    NSString *path = [self sandboxPath:fileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:NO]) {
        if (![[NSFileManager defaultManager] removeItemAtPath:path error:NULL]){
            
        }
	}
    BOOL result = [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
    id handle = [NSFileHandle fileHandleForWritingAtPath:path];
    [handle writeData:data];
    return result;
}

- (BOOL)removeFromSandbox:(NSString *)fileName {
    NSString *path = [self sandboxPath:fileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:NO]) {
        return [[NSFileManager defaultManager] removeItemAtPath:path error:NULL];
	}
    return NO;
}

- (void)clearSandbox {
    NSArray *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filename;
    NSDirectoryEnumerator *direnum = [[NSFileManager defaultManager] enumeratorAtPath:[documentsDirectory objectAtIndex:0]];
    while (filename = [direnum nextObject]) {
        BOOL flag = NO;
        if(engoreFiles){
            for(int i = 0;i < [engoreFiles count]; i++){
                NSString *tempName = [engoreFiles objectAtIndex:i];
                if([tempName isEqualToString:filename]){
                    flag = YES;
                    break;
                }
            }
        }
        if(!flag){
            [self removeFromSandbox:filename];
        }
    }
    
}

- (BOOL)uploadDataToiCloud:(NSString *)fileName {
    
    NSURL *sandboxPath = [NSURL fileURLWithPath:[self sandboxPath:fileName]];
    NSURL *icloudPath = [self iCloudURL:fileName];
    
    iCloudUploadResult result = UPLOAD_FAILED;
    if ([[NSFileManager defaultManager] isUbiquitousItemAtURL:icloudPath]) {
        NSData *localData = [self sandboxData:fileName];
        // 存在则修改
        if ([localData writeToURL:icloudPath atomically:YES]) {
            result = EXIST_UPLOAD_SUCCESS;
        }else{
            result = UNEXIT_SANDBOX_UPLOAD_FAILED;
        }
        if(self.delegate && [self.delegate respondsToSelector:@selector(iCloud:uploadToiCloud:)]){
            [self.delegate iCloud:self uploadToiCloud:result];
        }
        return result;
    }
    
    NSError *error;
    // 官方文档建议本方法不要在主进程里执行
    if ([[NSFileManager defaultManager] setUbiquitous:YES itemAtURL:sandboxPath destinationURL:icloudPath error:&error]) {
        result = UPLOAD_SUCCESS;
    }else{
        result = UPLOAD_FAILED;
        NSLog(@"error  %@",error);
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(iCloud:uploadToiCloud:)]){
        [self.delegate iCloud:self uploadToiCloud:result];
    }
    return result;
}

- (void)startSynchronizeData {
    //判断上同步到iCloud还是从iCloud同步下来
    iCloudType type = SYN_NOTHING_ICLOUD;
    
    //1.检测iCloud
    BOOL iCloudIsActive = [self checkiCloud];
    
    if(!iCloudIsActive){
        
        return;
    }
    
    
    //2.检测版本
    iCloudVersion version = [self checkVersion];
    
    if(version == VERSION_ICLOUD_NOT_ACTIVE){
        
        type = SYN_ICLOUD_NOT_ACTIVE;
    }else if(version == VERSION_CAN_SYN_TO_ICLOUD){
        
        type = SYN_TO_ICLOUD;
    }else if(version == VERSION_NEED_SYN_FROM_ICLOUD){
        
        type = SYN_FROM_ICLOUD;
    }else if(version == VERSION_LOCAL_NO_VERSION){
        
        type = SYN_FROM_ICLOUD;
    }else if(version == VERSION_ICLOUD_NO_VERSION){
        
        type = SYN_TO_ICLOUD;
    }else if(version == VERSION_NO_EFFECT_VERSION){
        
        type = SYN_FROM_ICLOUD;
    }
    
    BOOL result = NO;
    BOOL uploadOrDownload = NO;
    if(type == SYN_TO_ICLOUD){
        result = [self synchronizeDataToiCloud];
        NSLog(@"==synchronizeDataToiCloud==:%d",result);
        uploadOrDownload = YES;
        
    }else if(type == SYN_FROM_ICLOUD){
        result = [self synchronizeDataFromiCloud];
        NSLog(@"==synchronizeDataFromiCloud==:%d",result);
        uploadOrDownload = NO;
        
    }else if(type == SYN_ICLOUD_NOT_ACTIVE){
        
    }
    
    //    result = YES;
    //    uploadOrDownload = YES;
    if(result){
        //同步版本号
        [self synchronizeVersion:uploadOrDownload];
    }
    
}

- (BOOL)synchronizeDataToiCloud {
    
    iCloudUploadResult result = UPLOAD_FAILED;
    //    NSString *zipName = [[iCloudSynchronizer synchronizer] packageAllFiles];
    NSString *zipName = @"iClamp.sqlite";
    if(zipName){
        
        NSURL *sandboxPath = [NSURL fileURLWithPath:[self sandboxPath:zipName]];
        NSURL *icloudPath = [self iCloudURL:zipName];
        
        if ([[NSFileManager defaultManager] isUbiquitousItemAtURL:icloudPath]) {
            NSData *localData = [self sandboxData:zipName];
            // 存在则修改
            if ([localData writeToURL:icloudPath atomically:YES]) {
                result = EXIST_UPLOAD_SUCCESS;
            }else{
                result = UNEXIT_SANDBOX_UPLOAD_FAILED;
            }
            if(result == EXIST_UPLOAD_SUCCESS){
                //同步成功则删除.zip
                //                [self performSelectorOnMainThread:@selector(removeFromSandboxAfaterDelay:) withObject:zipName waitUntilDone:YES];
            }
            if(self.delegate && [self.delegate respondsToSelector:@selector(iCloud:synchronizeToiCloud:)]){
                
                [self.delegate iCloud:self synchronizeToiCloud:result];
            }
            //            NSLog(@"synchronizeDataToiCloud:%d",result);
            if(result == EXIST_UPLOAD_SUCCESS)
                return YES;
            return NO;
        }
        
        NSError *error;
        // 官方文档建议本方法不要在主进程里执行
        if ([[NSFileManager defaultManager] setUbiquitous:YES itemAtURL:sandboxPath destinationURL:icloudPath error:&error]) {
            result = UPLOAD_SUCCESS;
        }else{
            result = UPLOAD_FAILED;
        }
        if(result == UPLOAD_SUCCESS){
            //同步成功则删除.zip
            //            [self performSelectorOnMainThread:@selector(removeFromSandboxAfaterDelay:) withObject:zipName waitUntilDone:YES];
        }
        if(self.delegate && [self.delegate respondsToSelector:@selector(iCloud:synchronizeToiCloud:)]){
            [self.delegate iCloud:self synchronizeToiCloud:result];
        }
        //        NSLog(@"synchronizeDataToiCloud:%d",result);
        if(result == UPLOAD_SUCCESS)
            return YES;
        return NO;
    }
    return NO;
}

- (BOOL)synchronizeDataFromiCloud {
    //从iCloud 同步数据
    NSURL *icloudPath = [self iCloudURL:ICLOUD_ZIP_NAME];
    if(icloudPath){
        while ([self downloadFileIfNotAvailable:icloudPath]) {
            NSData *data = [[NSData alloc] initWithContentsOfURL:icloudPath];
            if(data){
                //这里删除掉本地的记录和缓存
                //                [self clearSandbox];
                
                [self saveToSandbox:data fileName:ICLOUD_ZIP_NAME];
                
                return YES;
            } else {
                [data release];
            }
        }
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(iCloud:synchronizeFromiCloud:data:)]){
        [self.delegate iCloud:self synchronizeFromiCloud:DOWNLOAD_FAILED data:nil];
    }
    return NO;
}

- (NSURL *)iCloudURL:(NSString *)fileName {
    // 验证iCloud是否激活
    NSURL *url = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
    if (url == nil) {
        //        NSLog(@"iCloud not active");
        return nil;
    }
    NSURL *icloudURL = [[NSURL URLWithString:fileName relativeToURL:url] copy];
    return icloudURL;
}

- (NSMutableDictionary *)downloadData:(NSString *)fileName {
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    NSURL *icloudPath = [self iCloudURL:fileName];
    if(icloudPath)
        [result setValue:icloudPath forKey:@"icloudPath"];
    if(icloudPath){
        BOOL downloadFileIfNotAvailable = [self downloadFileIfNotAvailable:icloudPath];
        while (downloadFileIfNotAvailable) {
            NSData *data = [[NSData alloc] initWithContentsOfURL:icloudPath];
            if(data){
                [result setValue:data forKey:@"data"];
                [data release];
                return result;
            }else {
                [data release];
            }
        }
    }
    return result;
}

- (NSData *)downloadDataFromiCloud:(NSString *)fileName {
    NSURL *icloudPath = [self iCloudURL:fileName];
    if(icloudPath){
        while ([self downloadFileIfNotAvailable:icloudPath]) {
            NSData *data = [[NSData alloc] initWithContentsOfURL:icloudPath];
            if(data){
                if(self.delegate && [self.delegate respondsToSelector:@selector(iCloud:downloadFromiCloud:data:)]){
                    [self.delegate iCloud:self downloadFromiCloud:DOWNLOAD_SUCCESS data:data];
                }
                [self saveToSandbox:data fileName:fileName];
                //广播
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_DOWNLODE_SUCCESS object:nil];
                return data;
            } else {
                [data release];
            }
        }
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(iCloud:downloadFromiCloud:data:)]){
        [self.delegate iCloud:self downloadFromiCloud:DOWNLOAD_FAILED data:nil];
    }
    return nil;
}

- (NSMutableArray *)listAllFiles {
    NSMutableArray *allFiles = [NSMutableArray array];
    NSArray *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filename;
    NSDirectoryEnumerator *direnum = [[NSFileManager defaultManager] enumeratorAtPath:[documentsDirectory objectAtIndex:0]];
    while (filename = [direnum nextObject]) {
        if(![filename isEqualToString:ICLOUD_ZIP_NAME]){
            BOOL flag = NO;
            if(engoreFiles){
                for(int i = 0;i < [engoreFiles count]; i++){
                    NSString *tempName = [engoreFiles objectAtIndex:i];
                    if([tempName isEqualToString:filename]){
                        flag = YES;
                        break;
                    }
                }
            }
            if(!flag){
                NSString *dir = currentDirectory ? [NSString stringWithFormat:@"/%@",currentDirectory] : @"";
                NSString *fileName = [NSString stringWithFormat:@"%@%@/%@",[documentsDirectory objectAtIndex:0],dir,filename];
                if(![[filename pathExtension] isEqualToString:@""]){
                    NSArray *array = [NSArray arrayWithObjects:filename,fileName, nil];
                    //这里是文件
                    [allFiles addObject:array];
                }
            }
        }
    }
    for(int i = 0;i < [allFiles count]; i++){
        NSArray *file = [allFiles objectAtIndex:i];
        NSLog(@"name:%@",[file objectAtIndex:0]);
    }
    return allFiles;
}

- (NSString *)packageAllFiles {
    @try {
        NSMutableArray *allFiles = [[self listAllFiles] retain];
        //压缩
        if([allFiles count] == 0){
            return nil;
        }
        ZipFile *zipFile = [[ZipFile alloc] initWithFileName:[self sandboxPath:ICLOUD_ZIP_NAME] mode:ZipFileModeCreate];
        
        for(int i = 0;i < [allFiles count]; i++){
            NSArray *fileNames = [allFiles objectAtIndex:i];
            NSString *fileName = [fileNames objectAtIndex:0];
            if(![fileName isEqualToString:ICLOUD_ZIP_NAME]){
                //这里进行压缩
                //                ZipWriteStream *stream = [zipFile writeFileInZipWithName:[fileNames objectAtIndex:0] compressionLevel:ZipCompressionLevelBest];
                ZipWriteStream *stream = [zipFile writeFileInZipWithName:[fileNames objectAtIndex:0] compressionLevel:ZipCompressionLevelNone];
                NSData *data = [NSData dataWithContentsOfFile:[fileNames objectAtIndex:1]];
                [stream writeData:data];
                [stream finishedWriting];
            }
        }
        [allFiles release];
        [zipFile close];
        [zipFile release];
        
        return ICLOUD_ZIP_NAME;
        
    }@catch (ZipException *ze) {
        
    }@catch (id e) {
        
    }
    return nil;
}

- (void)unPackageZipFile:(NSData *)data {
    @try {
        ZipFile *unzipFile = [[ZipFile alloc] initWithFileName:[self sandboxPath:ICLOUD_ZIP_NAME] mode:ZipFileModeUnzip];
        NSArray *infos = [unzipFile listFileInZipInfos];
        [unzipFile goToFirstFileInZip];
        for(int i = 0;i < [infos count]; i++) {
            FileInZipInfo *info = [infos objectAtIndex:i];
            ZipReadStream *read = [unzipFile readCurrentFileInZip];
            NSMutableData *data = [[[NSMutableData alloc] initWithLength:info.size] autorelease];
            NSInteger byteRead = [read readDataWithBuffer:data];
            NSLog(@"info:%@-%@-%d-%d == %d",info.name, info.date, info.size, info.level,byteRead);
            //保存文件
            [self saveToSandbox:data fileName:info.name];
            
            [read finishedReading];
            if(i != [infos count] - 1)
                [unzipFile goToNextFileInZip];
        }
        [unzipFile close];
        [unzipFile release];
        
        //解压缩完删除.zip
        [self performSelectorOnMainThread:@selector(removeFromSandboxAfaterDelay:) withObject:ICLOUD_ZIP_NAME waitUntilDone:YES];
        
        if(data){
            [[NSNotificationCenter defaultCenter] postNotificationName:SYNCHROINZE_DOWNLOAD_UNZIP_FINISH object:data];
        }
        
    }@catch (ZipException *ze) {
        
    }@catch (id e) {
        
    }
}

- (void)createFolderInCloud:(NSString *)folderName {
    //iCloud folder
    NSURL *ubiq = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
    NSURL *ubiquitousPackage = [[[ubiq URLByAppendingPathComponent:@"Documents"] URLByAppendingPathComponent:folderName]URLByAppendingPathComponent:@"file.txt"];
    //NSLog(@"%@",ubiquitousPackage.relativePath);
    UIDocument *doc = [[UIDocument alloc] initWithFileURL:ubiquitousPackage];
    
    [doc saveToURL:[doc fileURL] forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
        //        NSLog(@"success:%d",success);
    }];
}

- (void)addEngoreFileName:(NSString *)engoreFileName {
    if(!engoreFiles){
        engoreFiles = [[NSMutableArray alloc] init];
    }
    BOOL flag = NO;
    for(int i = 0;i < [engoreFiles count]; i++){
        NSString *str = [engoreFiles objectAtIndex:i];
        if([str isEqualToString:engoreFileName]){
            flag = YES;
            break;
        }
    }
    if(!flag){
        [engoreFiles addObject:engoreFileName];
    }
}

- (void)createVersion:(NSInteger)currentVersion {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filename = [path stringByAppendingPathComponent:ICLOUD_CURRENT_VERSION_PLIST];
    
    //创建一个dic，写到plist文件里
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",currentVersion],ICLOUD_CURRENT_VERSION,nil]; //写入数据
    [dic writeToFile:filename atomically:YES];
    
}

- (iCloudVersion)checkVersion {
    //比较当前的版本与iCloud 上的版本
    
    //如果iCloud上的版本号比当前的小,则使用iCloud上的版本，覆盖当前的版本
    
    //如果等于iCloud上的版本号,则把当前版本同步到iCloud
    
    //如果iCloud上没有版本号,则将当前版本同步到iCloud上,并在iCloud上建立一个版本号
    
    //每次同步之后,iCloud上的版本号 +1
    
    NSInteger iCloudVersion = [self iCloudVersion];
    if (iCloudVersion == -1) {
        iCloudVersion = [self iCloudVersion];
        iCloudVersion = [self iCloudVersion];
        iCloudVersion = [self iCloudVersion];
        iCloudVersion = [self iCloudVersion];
        iCloudVersion = [self iCloudVersion];
        iCloudVersion = [self iCloudVersion];
        iCloudVersion = [self iCloudVersion];    iCloudVersion = [self iCloudVersion];
        iCloudVersion = [self iCloudVersion];
        iCloudVersion = [self iCloudVersion];
        iCloudVersion = [self iCloudVersion];
        iCloudVersion = [self iCloudVersion];
    }
    
    if(iCloudVersion == -2){
        //iCloud不可用
        //        NSLog(@"iCloud not active");
        return VERSION_ICLOUD_NOT_ACTIVE;
    }
    if(iCloudVersion == -1){
        //无版本号
        //        NSLog(@"iCloud has no version");
        return VERSION_ICLOUD_NO_VERSION;
    }
    
    NSInteger localVersion = [self localVersion];
    if(localVersion == -1){
        //本地无版本号，第一次安装app的情况发生
        [self createVersion:0];
        //        NSLog(@"first install app,version is 0");
        return VERSION_LOCAL_NO_VERSION;
    }
    
    NSLog(@"localVersion:%d   iCloudVersion:%d",localVersion,iCloudVersion);
    if(localVersion < iCloudVersion){
        
        //当前版本比iCloud上的版本小,需要从iCloud上同步下来
        return VERSION_NEED_SYN_FROM_ICLOUD;
    }else if(localVersion == iCloudVersion){
        
        //当前版本跟iCloud上的版本一致,可以将iCloud上的版本更新掉
        return VERSION_CAN_SYN_TO_ICLOUD;
    }else{
        
        //当前的版本比iCloud上的版本大，(基本不存在这种情况)
        return VERSION_NO_EFFECT_VERSION;
    }
    
    return VERSION_ICLOUD_NO_VERSION;
}

- (BOOL)checkiCloud {
    NSURL *url = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
    if(url){
        [self performSelectorOnMainThread:@selector(invokeiCloudActiveDelegate:) withObject:[NSNumber numberWithBool:YES] waitUntilDone:YES];
        return YES;
    }else{
        [self performSelectorOnMainThread:@selector(invokeiCloudActiveDelegate:) withObject:[NSNumber numberWithBool:NO] waitUntilDone:YES];
        return NO;
    }
}

- (NSInteger)localVersion {
    //同步当前版本号
    NSString *filename = [self sandboxPath:ICLOUD_CURRENT_VERSION_PLIST];
    //获取路径
    NSDictionary *dic2 = [NSDictionary dictionaryWithContentsOfFile:filename];  //读取数据
    if(!dic2){
        return -1;
    }
    return [[dic2 objectForKey:ICLOUD_CURRENT_VERSION] intValue];
}

- (NSInteger)iCloudVersion {
    NSMutableDictionary *dataDic = [self downloadData:ICLOUD_CURRENT_VERSION_PLIST];
    NSString *icloudPath = [dataDic objectForKey:@"icloudPath"];
    if(!icloudPath){
        //iCloud不可用
        return -2;
    }
    NSData *data = [dataDic objectForKey:@"data"];
    if(!data){
        return -1;
    }
    if(data){
        NSDictionary *dic = [self dictionaryWithContentsOfData:data];
        if(dic){
            NSInteger iCloudVersion = [[dic objectForKey:ICLOUD_CURRENT_VERSION] intValue];
            return iCloudVersion;
        }
    }
    return -1;
}

- (void)synchronizeVersion:(BOOL)uploadOrDownload {
    
    NSInteger iCloudVersion = [self iCloudVersion];
    if(iCloudVersion == -2){
        return;
    }
    if(iCloudVersion == -1){
        //iCloud上无版本
        [self createVersion:1];
        [self uploadDataToiCloud:ICLOUD_CURRENT_VERSION_PLIST]; //这里上传到iCloud会删除version plist ,所以在本地需要再创建一次版本
        [self createVersion:1];
        //        NSLog(@"** upload ** : %d %d",[self localVersion],[self iCloudVersion]);
        
        return;
    }
    if(uploadOrDownload){
        //上传,iCloud版本加1
        [self createVersion:iCloudVersion + 1];
        [self uploadDataToiCloud:ICLOUD_CURRENT_VERSION_PLIST];//这里上传到iCloud会删除version plist ,所以在本地需要再创建一次版本
        [self createVersion:iCloudVersion + 1];
        //        NSLog(@"** upload ** : %d %d",[self localVersion],[self iCloudVersion]);
        
    }else{
        [self createVersion:iCloudVersion];
        //        NSLog(@"** download ** : %d %d",[self localVersion],[self iCloudVersion]);
        
    }
}

#pragma mark - lifecycle

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:instance name:SYNCHROINZE_DOWNLOAD_UNZIP_FINISH object:nil];
    if(engoreFiles){
        [engoreFiles release];
        engoreFiles = nil;
    }
    if(currentDirectory){
        [currentDirectory release];
        currentDirectory = nil;
    }
    if(currentDocumentDirectory){
        [currentDocumentDirectory release];
        currentDocumentDirectory = nil;
    }
    if(instance){
        [instance release];
        instance = nil;
    }
    [super dealloc];
}

@end
