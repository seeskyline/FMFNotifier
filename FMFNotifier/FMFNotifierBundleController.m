//
//  FMFNotifierBundleController.m
//  FMFNotifier
//
//  Created by Gianluca Puglia on 21/02/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "FMFNotifierBundleController.h"
#import <Preferences/PSSpecifier.h>

#define kUrl_FollowOnTwitter @"https://twitter.com/0xpooky"
#define kUrl_MakeDonation @"https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=56KLKJLXKM9FS"

#define kPrefs_Path @"/var/mobile/Library/Preferences"
#define kPrefs_Key @"key"
#define kPrefs_Defaults @"defaults"

@implementation FMFNotifierBundleController

- (id)getValueForSpecifier:(PSSpecifier*)specifier {
    NSLog(@"[FMFNotifierBundleController] - getValueForSpecifier");
    
	id value = nil;
    NSDictionary *specifierProperties = [specifier properties];
    NSString *specifierKey = [specifierProperties objectForKey:kPrefs_Key];
    NSString *plistPath = [[NSString alloc] initWithString:[specifierProperties objectForKey:kPrefs_Defaults]];
    plistPath = [NSString stringWithFormat:@"%@/%@.plist", kPrefs_Path, plistPath];
    if (plistPath) {
        if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
            return value;
        }
        //NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        //id objectValue = [dict objectForKey:specifierKey];
        //        if (password) {
        //            value = [NSString stringWithFormat:@"%@", objectValue];
        //            NSLog(@"read key '%@' with value '%@' from plist '%@'", specifierKey, value, plistPath);
        //        }
        //        else {
        //            NSLog(@"key '%@' not found in plist '%@'", specifierKey, plistPath);
        //
    }
	return nil;
}

- (void)setValue:(id)value forSpecifier:(PSSpecifier*)specifier {
    NSLog(@"[FMFNotifierBundleController] - setValue:forSpecifier");
    
	NSDictionary *specifierProperties = [specifier properties];
    NSString *specifierKey = [specifierProperties objectForKey:kPrefs_Key];
    NSString *plistPath = [[NSString alloc] initWithString:[specifierProperties objectForKey:kPrefs_Defaults]];
    plistPath = [NSString stringWithFormat:@"%@/%@.plist", kPrefs_Path, plistPath];
    if (plistPath) {
        if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
            return;
        }
        //NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
        //[dict setObject:value forKey:specifierKey];
        //[dict writeToFile:plistPath atomically:YES];
        NSLog(@"saved key '%@' with value '%@' to plist '%@'", specifierKey, value, plistPath);
        return;
    }
    return;
}

- (void)followOnTwitter:(PSSpecifier*)specifier {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:kUrl_FollowOnTwitter]];
}

- (void)makeDonation:(PSSpecifier *)specifier {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:kUrl_MakeDonation]];
}

- (id)specifiers {
    if(_specifiers == nil) {
        _specifiers = [[self loadSpecifiersFromPlistName:@"FMFNotifier" target:self] retain];
    }
    return _specifiers;
}

- (id)init {
    NSLog(@"[FMFNotifierBundleController] - init");
	if ((self = [super init])) {
        if (![[NSFileManager defaultManager] fileExistsAtPath:PreferencesPath]) {
            NSMutableDictionary *prefs = [[NSMutableDictionary alloc] init];
            [prefs setObject:[NSNumber numberWithBool:YES] forKey:@"rememberPassword"];
            [prefs setObject:[NSNumber numberWithBool:YES] forKey:@"notificationEnabled"];
            [prefs writeToFile:PreferencesPath atomically:YES];
        }
	}
	return self;
}

@end