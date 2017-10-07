//
//  VideoDetails.h
//  CCYoutube
//
//  Created by surya on 10/6/17.
//  Copyright © 2017 surya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoDetails : NSObject

@property (nonatomic, strong) NSString *videoId;
@property (nonatomic, strong) NSString *videoDescription;
@property (nonatomic, strong) NSString *videoTitle;
@property (nonatomic, strong) NSString *videoThumbnail;

@end
