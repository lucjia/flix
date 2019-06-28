//
//  DetailsViewController.m
//  flix
//
//  Created by lucjia on 6/26/19.
//  Copyright © 2019 lucjia. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import <QuartzCore/QuartzCore.h>

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backdropView;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextView *synopsisTextView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Start the activity indicator
    [self.activityIndicator startAnimating];
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = self.movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    [self.posterView setImageWithURL:posterURL];
    
    NSString *backdropURLString = self.movie[@"backdrop_path"];
    NSString *fullBackdropURLString = [baseURLString stringByAppendingString:backdropURLString];
    
    NSURL *backdropURL = [NSURL URLWithString:fullBackdropURLString];
    [self.backdropView setImageWithURL:backdropURL];
    
    self.titleLabel.text = self.movie[@"title"];
    self.synopsisTextView.text = self.movie[@"overview"];
    
//    NSMutableString *dateString = @"";
//    NSMutableString *monthString = [self.movie[@"release_date"] substringWithRange:NSMakeRange(5, 2)];
//
//    if ([monthString isEqualToString: @"01"]) {
//        [dateString appendString: @"January "];
//    } else if ([monthString isEqualToString: @"02"]) {
//        [dateString appendString: @"February "];
//    } else if ([monthString isEqualToString: @"03") {
//        [dateString appendString: @"March "];
//    } else if (self.movie[@"release_date"] substringWithRange:NSMakeRange(5, 2) = @"04") {
//        [dateString appendString: @"April "];
//    } else if (self.movie[@"release_date"] substringWithRange:NSMakeRange(5, 2) = @"05") {
//        [dateString appendString: @"May "];
//    } else if (self.movie[@"release_date"] substringWithRange:NSMakeRange(5, 2) = @"06") {
//        [dateString appendString: @"June "];
//    } else if (self.movie[@"release_date"] substringWithRange:NSMakeRange(5, 2) = @"07") {
//        [dateString appendString: @"July "];
//    } else if (self.movie[@"release_date"] substringWithRange:NSMakeRange(5, 2) = @"08") {
//        [dateString appendString: @"August "];
//    } else if (self.movie[@"release_date"] substringWithRange:NSMakeRange(5, 2) = @"09") {
//        [dateString appendString: @"September "];
//    } else if (self.movie[@"release_date"] substringWithRange:NSMakeRange(5, 2) = @"10") {
//        [dateString appendString: @"October "];
//    } else if (self.movie[@"release_date"] substringWithRange:NSMakeRange(5, 2) = @"11") {
//        [dateString appendString: @"November "];
//    } else {
//        [dateString appendString: @"December "];
//    }
//
    self.dateLabel.text = self.movie[@"release_date"];
    
    [self.titleLabel sizeToFit];
    [self.dateLabel sizeToFit];
    
    [self.posterView.layer setBorderColor: [[UIColor whiteColor] CGColor]];
    [self.posterView.layer setBorderWidth: 3.0];
    self.backdropView.alpha = 0.8;
    
//    CAGradientLayer *gradientView = [CAGradientLayer layer];
//    gradientView.frame = self.backdropView.bounds;
//    gradientView.colors = @[(id)[UIColor whiteColor].CGColor, (id)[UIColor clearColor].CGColor];
    
    // Stop the activity indicator
    // Hides automatically if "Hides When Stopped" is enabled
    [self.activityIndicator stopAnimating];
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
