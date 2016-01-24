//
//  ViewController.m
//  helloWorld
//
//  Created by Konto Piotrek on 12/01/16.
//  Copyright © 2016 Konto Piotrek. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSURLSessionDataDelegate>

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


- (void) URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self.loader stopAnimating];
    });
    
    
    
    NSError *errorJson=nil;
    NSDictionary* responseDict =[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&errorJson];
    
    NSString *accessToken = [responseDict objectForKey:@"access_token"];
    
    if ([accessToken length] > 0){
        //NSString *message = [NSString stringWithFormat:@"Received access key: %@", accessToken];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self navigateToSecondView];
        });
        
        
    }
    else{
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self showAllertWith:@"Access token not found in response"];
        });
        
    }

}

-(void) navigateToSecondView{
    [self performSegueWithIdentifier:@"navigateToSecondView" sender:self];
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
    
    [self authenticateWith:login and:password];
}

- (void) authenticateWith: (NSString*) login and:(NSString*) password
{
    [self.loader startAnimating];
    NSString* urlAsString = @"http://nprdiary.azurewebsites.net/api/token";
     NSURL* url = [NSURL URLWithString:urlAsString];
     
     NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
     [urlRequest setTimeoutInterval:30.0f];
     [urlRequest setHTTPMethod:@"POST"];
     
    NSString *body = [NSString stringWithFormat: @"grant_type=password&username=%@&password=%@",login, password];
     [urlRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
     [urlRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:urlRequest];
    
    [postDataTask resume];
    
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
