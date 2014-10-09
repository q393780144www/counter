//
//  YGHRootViewController.m
//  File
//
//  Created by YGH on 14-10-8.
//  Copyright (c) 2014年 ___YGH___. All rights reserved.
//

#import "YGHRootViewController.h"

@interface YGHRootViewController ()
@property (weak, nonatomic) IBOutlet UILabel *count;
@property (weak, nonatomic) IBOutlet UITextField *Url;
- (IBAction)File:(UIButton *)sender;

@end

@implementation YGHRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(NSUInteger)code:(NSString *)path
{
    NSFileManager *file=[NSFileManager defaultManager];
    BOOL dir=NO;
    BOOL exit=[file fileExistsAtPath:path isDirectory:&dir];
    if(!exit)
    {
        UIAlertView *alr=[[UIAlertView alloc]initWithTitle:@"警告" message:@"路径不存在，请重新输入" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles: nil];
        [alr show];
        return 0;
    }
    else
    {
       
        if (dir==YES) {
            int count=0;
            NSArray *fil=[file contentsOfDirectoryAtPath:path error:nil];
           
            for (NSString *full in fil) {
                NSString *fullname=[NSString stringWithFormat:@"%@/%@",path,full];
               
                count= [self code:fullname]+count;
               
            }
            return count;
            
        }
        else
        {
            NSString *extr=[[path pathExtension] lowercaseString];
            if ([extr isEqualToString:@"h"]||[extr isEqualToString:@"c"]||[extr isEqualToString:@"m"]) {
                NSString *cont=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
                NSArray *ary=[cont componentsSeparatedByString:@"\n"];
                 NSLog(@"%@",path);
                NSLog(@"%d",ary.count);
                return ary.count;
            }
            else
                return 0;
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)File:(UIButton *)sender {
    [self.view endEditing:YES];
    _count.text=[NSString stringWithFormat:@"%d",[self code:_Url.text]];
    
}
@end
