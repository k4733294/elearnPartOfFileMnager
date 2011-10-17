//
//  filemanager.m
//  FastPdfKit
//
//  Created by 劉 博昇 on 11/10/10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "filemanager.h"

@implementation filemanager
@synthesize filetableview;
@synthesize fileEntries,openfileEntries;



-(IBAction)actionBack:(id)sender{
NSLog(@"back");
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
            
     NSLog(@"init");   
        fileEntries = [[NSMutableArray alloc]init];
		openfileEntries = [[NSMutableArray alloc]init];
        // Custom initialization
    }
    return self;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"section");
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;{
NSLog(@"number");
    // Return the number of rows in the section.
    return [fileEntries count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;{
    NSLog(@"incellforrow");
    // Configure the cell...
    
    static NSString *cellId = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
	
	if(nil == cell) {
		
		cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId]autorelease];
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
		
	}
    
        return cell;
    
}
-(void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
   
    

	
    [super viewDidLoad];
    /*
    NSMutableArray *everyTitle;
    
    NSError *error = nil;
    
    NSFileManager *fileManager = [[NSFileManager defaultManager] init];  
    everyTitle = [[NSMutableArray alloc] init];  
    NSArray *filePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  
    NSString *filePath = [filePaths objectAtIndex:0];  
        NSLog(@"%@",filePath);      
    NSDirectoryEnumerator *direnum = [fileManager enumeratorAtPath:filePath];  
    //    NSMutableArray *array = [[NSMutableArray alloc] init];  
    NSString *fileName;  
    while ((fileName = [direnum nextObject])) {  
        if([[fileName pathExtension] isEqualToString:@"pdf"]){  
            
            NSArray *strings = [fileName componentsSeparatedByString:@"."];  
            NSString *fileTitle = [strings objectAtIndex:[strings count]-2];  
            
            [everyTitle addObject:fileTitle];  
            
        }  
    } */
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //在这里获取应用程序Documents文件夹里的文件及文件夹列表
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [documentPaths objectAtIndex:0];
    NSError *error = nil;
    NSArray *fileList = [[NSArray alloc] init];
    //fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
    fileList = [fileManager contentsOfDirectoryAtPath:documentDir error:&error];
    
    NSMutableArray *dirArray = [[NSMutableArray alloc] init];
    BOOL isDir = NO;
    //在上面那段程序中获得的fileList中列出文件夹名
    for (NSString *file in fileList) {
        NSString *path = [documentDir stringByAppendingPathComponent:file];
        [fileManager fileExistsAtPath:path isDirectory:(&isDir)];
        if (isDir) {
            [dirArray addObject:file];
        }
        isDir = NO;
    }
    NSLog(@"Every Thing in the dir:%@",fileList);
    NSLog(@"All folders:%@",dirArray);
    
    //int count =[everyTitle count];
    /*for(int i=0;i<count;i++){
        NSString *file=[everyTitle objectAtIndex:i];
        NSLog(@"%@",file);
    }*/
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [ self.filetableview reloadData ];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
