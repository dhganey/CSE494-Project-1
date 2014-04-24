//
//  TabBarViewController.m
//  Project 1
//
//  Created by David Ganey on 4/9/14.
//  Copyright (c) 2014 Ganey/Alfheim Industries. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

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
    // Do any additional setup after loading the view.
    
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Fancy Tab" image:[UIImage imageNamed:@"FancyTab"] tag:1];
    tabBarItem = tabBarItem; // to set the tabBarItem from outside the viewController
    self.tabBarItem = tabBarItem;             // to set the tabBarItem from inside the viewController

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
