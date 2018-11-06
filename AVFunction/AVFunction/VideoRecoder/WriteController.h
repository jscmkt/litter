//
//  WriteController.h
//  AVFunction
//
//  Created by shoule on 2018/8/27.
//  Copyright © 2018年 WT. All rights reserved.
//

#import <UIKit/UIKit.h>

//录制状态，（这里把视频录制与写入合并成一个状态）
typedef NS_ENUM(NSInteger, FMRecordState){
    FMRecordStateInit = 0,
    FMRecordStatePrepareRecording,
    FMRecordStateRecording,
    FMRecordStateFinish,
    FMRecordStateFail,
};
@interface WriteController : UIViewController
@property(nonatomic,assign) FMRecordState writeState;
@end
