//
//  ViewController.h
//  helloWorld
//
//  Created by Konto Piotrek on 12/01/16.
//  Copyright © 2016 Konto Piotrek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *loginTexbox;
@property (strong, nonatomic) IBOutlet UITextField *passwordTexbox;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loader;


- (IBAction)loginButtonClick:(id)sender;
@end

