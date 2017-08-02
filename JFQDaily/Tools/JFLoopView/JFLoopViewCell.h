//
//  JFLoopViewCell.h
//  MaYi
//
//  Created by 张志峰 on 2016/10/29.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JFLoopViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *imageName;    // 轮播图片url字符串 （需要转换成URL）
@property (nonatomic, copy) NSString *title;        // 轮播新闻标题
@end
