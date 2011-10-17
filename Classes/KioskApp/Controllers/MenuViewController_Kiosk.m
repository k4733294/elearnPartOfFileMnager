//
//  MenuViewController_Kiosk.m
//  FastPdfKit Sample
//
//  Created by Gianluca Orsini on 28/02/11.
//  Copyright 2010 MobFarm S.r.l. All rights reserved.
//

#import "MenuViewController_Kiosk.h"
#import "MFDocumentManager.h"
#import "ReaderViewController.h"
#import "MFHomeListPdf.h"
#import "XMLParser.h"
#include <stdio.h>
#include <stdlib.h>

//#define FPK_KIOSK_XML_URL @"http://go.mobfarm.eu/pdf/kiosk_list.xml"

#define FPK_KIOSK_XML_URL @"http://www.google.com/search?hl=zh-TW&client=safari&rls=en&biw=1278&bih=642&q=pdf&oq=pdf&aq=f&aqi=&aql=&gs_sm=e&gs_upl=35534l35534l0l35731l1l1l0l0l0l0l0l0ll0l0"

#define FPK_KIOSK_XML_NAME @"kiosk_list"

@implementation MenuViewController_Kiosk

@synthesize buttonRemoveDict;
@synthesize openButtons;
@synthesize progressViewDict,imgDict;
@synthesize documentsList;
@synthesize graphicsMode;
//----------------------------------------
@synthesize documents,currentItem;
//----------------------------------------

@synthesize myWevView;
@synthesize myAlertView;


-(IBAction)start:(id)sender
{
    XMLParser *parser = nil;
    NSURL * xmlUrl = nil;
	
	UIScrollView * aScrollView = nil;
	CGFloat yBorder = 0 ; 
	UIImageView * anImageView = nil;
	
	CGRect frame;
	NSString * titoloPdf = nil;
    NSString * Pdftitle = nil;
    NSString * titoloPdfNoSpace = nil;
	NSString * linkPdf = nil;
	NSString * copertinaPdf = nil;
    
	MFHomeListPdf * viewPdf = nil;
    
	int documentsCount; // Used to iterate over each item in the list.
	
	//Graphics visualization
	
	CGFloat thumbWidth;
	CGFloat thumbHeight;
	CGFloat scrollViewWidth;
	CGFloat scrollViewHeight;
	CGFloat detailViewHeight;
	CGFloat thumbHOffsetLeft;
	CGFloat thumHOffsetRight;
	CGFloat frameHeight;
	CGFloat scrollViewVOffset;
	
	if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		
		thumbWidth = 350.0;
		thumbHeight = 480.0;
		thumbHOffsetLeft = 20.0;
		thumHOffsetRight = 380.0;
		frameHeight = 325.0;
		scrollViewWidth = 771.0;
		scrollViewHeight = 475.0;
		detailViewHeight = 765.0;
		scrollViewVOffset = 530.0;
		
	} else {
		
		thumbWidth = 125.0;
		thumbHeight = 170.0;
		thumbHOffsetLeft = 10.0;
		thumHOffsetRight = 160.0;
		frameHeight = 115.0;
		scrollViewWidth = 323.0;
		scrollViewHeight = 404.0;
		detailViewHeight = 240.0;
		scrollViewVOffset = 60.0;
	}
	
	
	parser = [[XMLParser alloc] init];
	xmlUrl = [NSURL URLWithString:FPK_KIOSK_XML_URL];
    [parser parseXMLFileAtURL:xmlUrl];
	
    // Try to parse the remote URL. If it fails, fallback to the local xml.
    //--------------------原本由xml提供檔案訊息的產生地方---------------
    if([parser isDone]) {
        
        self.documentsList = [parser parsedItems];    
        
    } else {
        
        xmlUrl = [MF_BUNDLED_BUNDLE(@"FPKKioskBundle") URLForResource:FPK_KIOSK_XML_NAME withExtension:@"xml"];
        [parser parseXMLFileAtURL:xmlUrl];
        
        if([parser isDone]) {
            self.documentsList = [parser parsedItems];
        }
    }
	
	[parser release];
    
	//---------------------------------------------
    //----------底下原是運算從xml得到的資料做迴圈一個個從陣列讀出 部分語法往上改-------
    
	documentsCount = 10;  // 假設有10個  [documentsList count]; 
	//產生檔案與檔案間的圖形編排方式  先禁止移除！！！！！做測試------------
	aScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, scrollViewVOffset, scrollViewWidth, scrollViewHeight)];
	aScrollView.backgroundColor = [UIColor whiteColor];
	aScrollView.contentSize = CGSizeMake(scrollViewWidth, detailViewHeight * ((documentsCount/2)+(documentsCount%2)));
	//-----------------------------
    //----------底下原是運算從xml得到的資料做迴圈一個個從陣列讀出 部分語法往下改-------
    
	//for (int i=1; i<= documentsCount ; i++) {
		
	//	titoloPdf = [[documentsList objectAtIndex: i-1] objectForKey: @"title"];
    //    titoloPdfNoSpace = [titoloPdf stringByReplacingOccurrencesOfString:@" " withString:@""];
	//	linkPdf = [[documentsList objectAtIndex: i-1] objectForKey: @"link"];
	//	copertinaPdf = [[documentsList objectAtIndex: i-1] objectForKey: @"cover"];
        
        //----------------documentlist格式自定的位置 
        //---我改的部份    抓出重點欄位先把直改上去
        //                其他還有許多檔案相依的關係 需要修正 需要細談
        //----------------------------------------------------------------
        
       // NSMutableArray * documentsArray = [[NSMutableArray alloc] init];
       // self.documents = documentsArray;
       // [documentsArray release];
        
       // NSMutableDictionary * dictionary = nil;
        //dictionary = [[NSMutableDictionary alloc] init];
        //self.currentItem = dictionary;
    
        
        
        linkPdf =@"http://192.192.155.89/upload/Java.How.to.Program,7th.Edition.pdf";
       // titoloPdf＝@"45612jkljkl3151656";
        titoloPdf =[NSString stringWithFormat:@"Java.How.to.Program,7th.Edition"];
    NSLog(@"%@",titoloPdf);
        titoloPdfNoSpace = [titoloPdf stringByReplacingOccurrencesOfString:@" " withString:@""]; 
    
        
        //-------------------------------------------------------------------
       		
  //  先假設迴圈產生menu的檔案列表
    for (int i=1; i<= documentsCount ; i++){
        
        //這邊有動過手腳 還要給對面是地幾個檔案 numdoc現設為10
        viewPdf = [[MFHomeListPdf alloc] initWithName:titoloPdfNoSpace andTitoloPdf:titoloPdf andLinkPdf:linkPdf andnumOfDoc:i andImage:copertinaPdf andSize:CGSizeMake(thumbWidth, thumbHeight)];
    
    frame = self.view.frame;

        
		if ((i%2)==0) {
			frame.origin.y = (frameHeight * 2 ) * ( (i-1) / 2 );
			frame.origin.x = thumHOffsetRight;
			frame.size.width = thumbWidth;
			frame.size.height = detailViewHeight;
		}else {
			frame.origin.y = frameHeight *(i-1);
			frame.origin.x = thumbHOffsetLeft;
			frame.size.width = thumbWidth;
			frame.size.height = detailViewHeight;
		}

		
		viewPdf.view.frame = frame;
		viewPdf.menuViewController = self;
		[aScrollView addSubview:viewPdf.view];
		
		// Adding stuff to their respective containers.
		
		[imgDict setValue:viewPdf.openButtonFromImage forKey:titoloPdfNoSpace];
		[openButtons setValue:viewPdf.openButton forKey:titoloPdfNoSpace];
		[buttonRemoveDict setValue:viewPdf.removeButton forKey:titoloPdfNoSpace];
		[progressViewDict setValue:viewPdf.progressDownload forKey:titoloPdfNoSpace];
		
		[homeListPdfs addObject:viewPdf];
		[viewPdf release];
        }
	//	
	
	
	[self.view addSubview:aScrollView];
	// self.scrollView = aScrollView; // Not referenced anywhere else.
	[aScrollView release];
	
	// Border.
	
	if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		yBorder = scrollViewVOffset-3 ;
	}else {
		yBorder = scrollViewVOffset-1 ;
	}
	
	anImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, yBorder, scrollViewWidth, 40)]; 
	[anImageView setImage:[UIImage imageWithContentsOfFile:MF_BUNDLED_RESOURCE(@"FPKKioskBundle",@"border",@"png")]];
	[self.view addSubview:anImageView];
	[anImageView release];

}
////-----------------------------------//////

- (void)willPresentAlertView:(UIAlertView *)alertView
{
	CGRect frame = alertView.frame;
	if( alertView==myAlertView )
	{
		frame.origin.y -= 120;
		frame.size.height += 80;
		alertView.frame = frame;
		for( UIView * view in alertView.subviews )
		{
            //列舉alertView中所有的物件
			if( ![view isKindOfClass:[UILabel class]] )
			{
                //若不UILable則另行處理
                if (view.tag==1)
                {
                    //處理第一個按鈕，也就是 CancelButton
                   	CGRect btnFrame1 =CGRectMake(30, frame.size.height-65, 105, 40);
                    view.frame = btnFrame1;
                    
                } else if  (view.tag==2){
                    //處理第二個按鈕，也就是otherButton    
                    CGRect btnFrame2 =CGRectMake(142, frame.size.height-65, 105, 40);
                    view.frame = btnFrame2;
                    
                }
			}
		}
		
        //加入自訂的label及UITextFiled
        UILabel *lblaccountName=[[UILabel alloc] initWithFrame:CGRectMake( 30, 50,60, 30 )];;
        lblaccountName.text=@"帳號：";
        lblaccountName.backgroundColor=[UIColor clearColor];
        lblaccountName.textColor=[UIColor whiteColor];
        
        NSString *pass = [[NSUserDefaults standardUserDefaults]objectForKey:@"userpass"];
        NSString *name = [[NSUserDefaults standardUserDefaults]objectForKey:@"username"];         
        accoutName = [[UITextField alloc] initWithFrame: CGRectMake( 85, 50,160, 30 )];   
        accoutName.placeholder =@"輸入帳號";
        accoutName.borderStyle=UITextBorderStyleRoundedRect;
        
        
        UILabel *lblaccountPassword=[[UILabel alloc] initWithFrame:CGRectMake( 30, 85,60, 30 )];;
        lblaccountPassword.text=@"密碼：";
        lblaccountPassword.backgroundColor=[UIColor clearColor];
        lblaccountPassword.textColor=[UIColor whiteColor];
        
        accoutPassword = [[UITextField alloc] initWithFrame: CGRectMake( 85, 85,160, 30 )];   
        accoutPassword.placeholder=@"輸入密碼";
        accoutPassword.borderStyle=UITextBorderStyleRoundedRect;
        //輸入的資料以星號顯示（密碼資料）
        accoutPassword.secureTextEntry=YES;
        
     	[alertView addSubview:lblaccountName];
		[alertView addSubview:accoutName];         
        [alertView addSubview:lblaccountPassword];
		[alertView addSubview:accoutPassword];
	}
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //NSString * ttxt;
    //   NSString * accoutPassword;
    //ttxt = @"asd";
    //NSLog(@"%@",accoutName.text);
    /*NSUserDefaults *userpassword;
    userpassword = [NSUserDefaults standardUserDefaults];
    [userpassword setObject:accoutPassword.text forKey:@"userpass"];
    [userpassword setObject:accoutName.text forKey:@"username"];
    [userpassword synchronize];
     */
    
    NSString *pass = [[NSUserDefaults standardUserDefaults]objectForKey:@"userpass"];
    NSString *name = [[NSUserDefaults standardUserDefaults]objectForKey:@"username"];   
    //NSLog(@"%@",pass);
    //NSLog(@"%@",name); 	
    if (buttonIndex == 0) {
        // ccountName = (TextFieldIndex == 0).text;
        [myWevView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"var field = document.getElementById('username');" 
                                                           "field.value='%@'", accoutName.text]];
    }
    else if (buttonIndex == 1) {
        
        /*[myWevView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById('username').value='%@'", accoutName.text]];
        [myWevView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById('password').value='%@'", accoutPassword.text]];
        [myWevView stringByEvaluatingJavaScriptFromString:@"var field3 = document.getElementsByTagName('button')[0];"
         "field3.click();"];  
         */
        
        NSLog(@"login");
        
        [myWevView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById('username').value='%@'", accoutName.text]];
        [myWevView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById('password').value='%@'", accoutPassword.text]];
        [myWevView stringByEvaluatingJavaScriptFromString:@"var field3 = document.getElementsByTagName('button')[0];"
         "field3.click();"];
            NSUserDefaults *userpassword;
            userpassword = [NSUserDefaults standardUserDefaults];
            [userpassword setObject:accoutPassword.text forKey:@"userpass"];
            [userpassword setObject:accoutName.text forKey:@"username"];
            [userpassword synchronize];           
        
        
        //NSLog(@"%@",accoutName);
        //NSLog(@"%@",accoutPassword);
        /*NSUserDefaults *userpassword;
        userpassword = [NSUserDefaults standardUserDefaults];
        [userpassword setObject:accoutPassword.text forKey:@"userpass"];
        [userpassword setObject:accoutName.text forKey:@"username"];
        [userpassword synchronize];
            
        NSString *pass = [[NSUserDefaults standardUserDefaults]objectForKey:@"userpass"];
        NSString *name = [[NSUserDefaults standardUserDefaults]objectForKey:@"username"];   
        NSLog(@"%@",pass);
        NSLog(@"%@",name); 
         */      
       /* else{
        [myWevView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById('username').value='%@'", name]];
        [myWevView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById('password').value='%@'", pass]];
        [myWevView stringByEvaluatingJavaScriptFromString:@"var field3 = document.getElementsByTagName('button')[0];"
         "field3.click();"];
            //NSLog(@"%@",pass);
            //NSLog(@"%@",name);         
            
        }*/
    }
    
    
}



////-----------------------------------//////


-(IBAction)actionOpenPlainDocument:(NSString *)documentName {
	
	MFDocumentManager * documentManager = nil;
	ReaderViewController * documentViewController = nil;
	
	NSArray *paths = nil;
	NSString *documentsDirectory = nil;
	NSString *pdfPath = nil;
	NSURL *documentUrl = nil;
	
	paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	documentsDirectory = [paths objectAtIndex:0];
	pdfPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@.pdf",documentName,documentName]];
	documentUrl = [NSURL fileURLWithPath:pdfPath];
    
    pdfPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",documentName]];
	//pdfPath = @"http://www.google.com/url?sa=t&source=web&cd=7&ved=0CFwQFjAG&url=http%3A%2F%2Fwww.cto.moea.gov.tw%2F04%2Fregister%2Fregister.pdf&ei=mGyBTpzyFsvnmAWwmIk_&usg=AFQjCNEgxpV4FPei2hHBUQ_oU5ugfUwkZA";
	
	
	// Now that we have the URL, we can allocate an istance of the MFDocumentManager class and use
	// it to initialize an MFDocumentViewController subclass 	
	
	documentManager = [[MFDocumentManager alloc]initWithFileUrl:documentUrl];
    
    documentManager.resourceFolder = pdfPath;
	
	documentViewController = [[ReaderViewController alloc]initWithDocumentManager:documentManager];
	documentViewController.documentId = documentName;
	
	[[self navigationController]pushViewController:documentViewController animated:YES];
    
	[documentViewController release];
	[documentManager release];
	
	
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {

	if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		
		buttonRemoveDict = [[NSMutableDictionary alloc] init];
		openButtons = [[NSMutableDictionary alloc] init];
		progressViewDict = [[NSMutableDictionary alloc] init];
		imgDict = [[NSMutableDictionary alloc] init];
		
		homeListPdfs = [[NSMutableArray alloc]init];
		
	}
	
	return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    //NSLog(@"start load");  
}
- (void)viewDidLoad {
    
        
    [myWevView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://elearn.shu.edu.tw"]]];
    [[[myWevView subviews] lastObject]setScrollEnabled:NO];
            //NSLog(@"%@",pass);
        //NSLog(@"%@",name); 
     
        
        
    
	[super viewDidLoad];
    myWevView.delegate=self;
	
		
}



-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *nsenter = @"http://elearn.shu.edu.tw/";
    NSURL *enter = [NSURL URLWithString:nsenter];
    NSString *nsindex = @"http://elearn.shu.edu.tw/learn/index.php";
    NSURL *index = [NSURL URLWithString:nsindex];
    //NSLog(@"%@",enter);
    NSString *myurl= myWevView.request.URL.absoluteString;
    //NSLog(@"%@",myurl); 
    if(nsenter == myurl)
    {
        NSLog(@"gGG");
    
    }

    //NSLog(@"%@",myWevView.request.URL);
    NSString *pass = [[NSUserDefaults standardUserDefaults]objectForKey:@"userpass"];
    NSString *name = [[NSUserDefaults standardUserDefaults]objectForKey:@"username"]; 
    //NSURL *erro="http://www.google.com/"+("%@",name);
    //NSLog(@"%@",erro);
    if (pass==nil) {
        myAlertView= [[UIAlertView alloc] initWithTitle:@"系統登入" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登入",nil];
        
        [myAlertView show];
    }
    else{
        //NSLog(@"%@",name);  
        //NSLog(@"%@",pass);
        
        [myWevView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById('username').value='%@'", name]];
        [myWevView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById('password').value='%@'", pass]];
        [myWevView stringByEvaluatingJavaScriptFromString:@"var field3 = document.getElementsByTagName('button')[0];"
         "field3.click();"];
    }
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    if(interfaceOrientation == UIDeviceOrientationPortrait){
        
		return YES;
        
	} else {
        
		return NO;
	}
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    
    [super viewDidUnload];
	
    [buttonRemoveDict removeAllObjects];
	[openButtons removeAllObjects];
	[progressViewDict removeAllObjects];
	[imgDict removeAllObjects];
	[homeListPdfs removeAllObjects];
	
}


- (void)dealloc {
	
	[documentsList release];
	
	[buttonRemoveDict release];
	[openButtons release];
	[progressViewDict release];
	[imgDict release];
	[downloadProgressContainerView release];
    [downloadProgressView release];
    
	[homeListPdfs release];
	
    [super dealloc];
}

@end
