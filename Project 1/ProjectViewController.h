//
//  ProjectViewController.h
//  Project 1
//
//  Created by David Ganey on 3/6/14.
//  Copyright (c) 2014 Ganey/Alfheim Industries. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
- (IBAction)nameEdited:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *nameField;

@end
