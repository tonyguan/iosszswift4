//
//  Help.c
//  SystemSound
//
//  Created by tonymacmini on 15/1/27.
//  Copyright (c) 2015年 tonyguan. All rights reserved.
//

#include "Help.h"

//定义一个回调函数，用于当声音播放完成之后回调。
void SoundFinishedPlayingCallback(SystemSoundID sound_id, void* user_data)
{
    //注销声音播放完成事件回调函数。
    AudioServicesRemoveSystemSoundCompletion(sound_id);
    //释放SystemSoundID
    AudioServicesDisposeSystemSoundID(sound_id);
}

AudioServicesSystemSoundCompletionProc completionHandler() {
    return SoundFinishedPlayingCallback;
}