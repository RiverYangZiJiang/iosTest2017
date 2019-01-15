//
//  CommentModel.m
//  iosTest2017
//
//  Created by yangzijiang on 2019/1/14.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel
- (instancetype)initWithDeviceModel:(NSString *)device_model feedback_desc:(NSString *)feedback_desc feedback_time:(NSString *)feedback_time rating:(NSString *)rating user:(NSString *)user
{
    self = [super init];
    if (self) {
        self.device_model = device_model;
        self.feedback_desc = feedback_desc;
        self.feedback_time = feedback_time;
        self.rating = rating;
        self.user = user;
    }
    return self;
}

+ (NSMutableArray *)testData{
    CommentModel *model1 = [[CommentModel alloc] initWithDeviceModel:@"iPhone X" feedback_desc:@"You can use it for daily attendance" feedback_time:@"2018-11-14" rating:@"5" user:@"Gwe6293289"];
    CommentModel *model2 = [[CommentModel alloc] initWithDeviceModel:@"iPhone X" feedback_desc:@"123212312312312123123212312312312123123212312312312123123212312312312123123212312312312123123212312312312123123212312312312123123212312312312123123212312312312123123212312312312123end" feedback_time:@"2018-11-14" rating:@"3" user:@"Gwe6293289"];
    CommentModel *model3 = [[CommentModel alloc] initWithDeviceModel:@"iPhone X" feedback_desc:@"You can use it for daily attendance You can use it for daily attendance." feedback_time:@"2018-11-14" rating:@"0" user:@"Gwe6293289"];
    CommentModel *model4 = [[CommentModel alloc] initWithDeviceModel:@"iPhone X" feedback_desc:@"You can use it for daily attendance You can use it for daily attendance." feedback_time:@"2018-11-14" rating:@"1" user:@"Gwe6293289"];
    CommentModel *model5 = [[CommentModel alloc] initWithDeviceModel:@"iPhone X" feedback_desc:@"You can use it for daily attendance You can use it for daily attendance." feedback_time:@"2018-11-14" rating:@"5" user:@"Gwe6293289"];
    CommentModel *model6 = [[CommentModel alloc] initWithDeviceModel:@"iPhone X" feedback_desc:@"You can use it for daily attendance You can use it for daily attendance." feedback_time:@"2018-11-14" rating:@"5" user:@"Gwe6293289"];
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[model1, model2, model3, model4, model5, model6]];
    return array;
}
@end
