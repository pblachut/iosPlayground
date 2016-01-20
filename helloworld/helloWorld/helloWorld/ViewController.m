//
//  ViewController.m
//  helloWorld
//
//  Created by Konto Piotrek on 12/01/16.
//  Copyright © 2016 Konto Piotrek. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonClick:(id)sender {
    
    NSString *login = [self.loginTexbox.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    
    if ([login length] == 0){
        [self showAllertWith:@"login cannot be empty"];
    }
    
    NSString *password = [self.passwordTexbox.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    
    if ([password length] == 0){
        [self showAllertWith:@"password cannot be empty"];
    }
    
    

    
    
    
}

- (void)showAllertWith: (NSString*)message{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                               {
                                   NSLog(@"OK action");
                               }];
    
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion: nil];
}

@end
