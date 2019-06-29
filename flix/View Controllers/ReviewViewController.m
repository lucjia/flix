//
//  ReviewViewController.m
//  flix
//
//  Created by lucjia on 6/28/19.
//  Copyright © 2019 lucjia. All rights reserved.
//

#import "ReviewViewController.h"
#import "ReviewCell.h"

@interface ReviewViewController ()
@property (weak, nonatomic) IBOutlet UITableView *reviewTableView;
@property (nonatomic, strong) NSArray *reviews;

@end

@implementation ReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.reviewTableView.dataSource = self;
    self.reviewTableView.delegate = self;
    self.reviewTableView.rowHeight = 208;
    
    [self fetchReviews];

}

-(void)fetchReviews {
    NSString *baseURLString = @"https://api.themoviedb.org/3/movie/";
    NSLog(@"%@", baseURLString);
    NSString *movieID = [self.movie[@"id"] stringValue];
    NSLog(@"%@", self.movie[@"id"]);
    NSLog(@"%@", movieID);
    NSString *soFar = [baseURLString stringByAppendingString:movieID];
    NSLog(@"%@", soFar);
    NSString *endURLString = @"/reviews?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed";
    NSLog(@"%@", endURLString);
    NSString *fullString = [soFar stringByAppendingString:endURLString];
    NSLog(@"%@", fullString);
    
    NSURL *url = [NSURL URLWithString:fullString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Cannot Get Movies"
                                                                           message:@"The internet connection appears to be offline."
                                                                    preferredStyle:(UIAlertControllerStyleAlert)];
            // create a try again action
            UIAlertAction *tryAgainAction = [UIAlertAction actionWithTitle:@"Try Again"
                                                                     style:UIAlertActionStyleCancel
                                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                                       // handle cancel response here. Doing nothing will dismiss the view.
                                                                       [self fetchReviews];
                                                                   }];
            // add the cancel action to the alertController
            [alert addAction:tryAgainAction];
            
            [self presentViewController:alert animated:YES completion:^{
                // optional code for what happens after the alert controller has finished presenting
            }];
        }
        else {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            self.reviews = dataDictionary[@"results"];
            for (NSDictionary *review in self.reviews) {
                NSLog(@"%@", review[@"content"]);
            }
            
            [self.reviewTableView reloadData];
        }
            // TODO: Get the array of movies
            // TODO: Store the movies in a property to use elsewhere
            // TODO: Reload your table view data
            
            // Stop the activity indicator
            // Hides automatically if "Hides When Stopped" is enabled\
            }
    }];
    [task resume];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.reviews.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReviewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReviewCell" forIndexPath:indexPath];
    
    NSDictionary *reviews = self.reviews[indexPath.row];
    cell.reviewerLabel.text = reviews[@"author"];
    cell.reviewTextView.text = reviews[@"content"];

    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
