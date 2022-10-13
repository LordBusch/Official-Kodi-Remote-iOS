//
//  VersionCheck.m
//  Kodi Remote
//
//  Created by Andree Buschmann on 13.10.22.
//  Copyright © 2022 Team Kodi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "VersionCheck.h"

@implementation VersionCheck

+ (BOOL)hasRecordingIdPlaylistSupport {
    // Since API 12.7.0 Kodi server can handle Playlist.Insert and Playlist.Add for recordingid.
    return (AppDelegate.instance.APImajorVersion == 12 && AppDelegate.instance.APIminorVersion >= 7) || AppDelegate.instance.APImajorVersion > 12;
}

+ (BOOL)hasGroupSingleItemSetsSupport {
    // GroupSingleItemSets is enabled (supported from API 6.32.4 on)
    return (AppDelegate.instance.APImajorVersion >= 7) ||
           (AppDelegate.instance.APImajorVersion == 6 && AppDelegate.instance.APIminorVersion >= 33) ||
           (AppDelegate.instance.APImajorVersion == 6 && AppDelegate.instance.APIminorVersion == 32 && AppDelegate.instance.APIpatchVersion >= 4);
}

@end
