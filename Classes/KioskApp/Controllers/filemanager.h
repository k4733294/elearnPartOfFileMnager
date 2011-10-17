//
//  filemanager.h
//  FastPdfKit
//
//  Created by 劉 博昇 on 11/10/10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "MenuViewController_Kiosk.h"

@class DocumentViewController;

@interface filemanager : UIViewController<UITableViewDataSource,UITableViewDelegate>{
       
    IBOutlet UITableView *filetableview;
    
    NSMutableArray *fileEntries;
	NSMutableArray *openfileEntries;
    
}

-(IBAction)actionBack:(id)sender;

@property(nonatomic,assign)IBOutlet UITableView *filetableview;
@property (nonatomic, retain) NSArray *fileEntries;
@property (nonatomic, retain) NSArray *openfileEntries;
//@property (nonatomic, assign) NSObject<OutlineViewControllerDelegate> *delegate;
@end
