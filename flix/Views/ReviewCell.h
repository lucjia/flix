//
//  ReviewCell.h
//  flix
//
//  Created by lucjia on 6/28/19.
//  Copyright © 2019 lucjia. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReviewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *reviewerLabel;
@property (weak, nonatomic) IBOutlet UITextView *reviewTextView;


@end

NS_ASSUME_NONNULL_END
