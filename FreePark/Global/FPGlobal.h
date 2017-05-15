//
//  FreeParkDefine.h
//  FreePark
//
//  Created by LovelyPony on 20/02/2016.
//  Copyright © 2016 TanWernling. All rights reserved.
//

#ifndef FreeParkDefine_h
#define FreeParkDefine_h


//-------------------------------------------------------------------------
// Color
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

// Logs
#ifdef DEBUG
#define DLog(...) NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSString stringWithFormat:__VA_ARGS__])
#else
#define DLog(...) do { } while (0)
#endif

//-------------------------------------------------------------------------
// OS version
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending

//-------------------------------------------------------------------------
// Fonts
#define LATO_REGULAR(x) [UIFont fontWithName:@"Lato-Regular" size:x]
#define LATO_BOLD(x) [UIFont fontWithName:@"Lato-Bold" size:x]
#define LATO_LIGHT(x) [UIFont fontWithName:@"Lato-Light" size:x]
#define LATO_ITALIC(x) [UIFont fontWithName:@"Lato-Italic" size:x]
#define LATO_BLACK(x) [UIFont fontWithName:@"Lato-Black" size:x]
#define LATO_HAIRLINE(x) [UIFont fontWithName:@"Lato-Hairline" size:x]
#define LATO_BOLD_ITALIC(x) [UIFont fontWithName:@"Lato-BoldItalic" size:x]
#define LATO_BLACK_ITALIC(x) [UIFont fontWithName:@"Lato-BlackItalic" size:x]
#define LATO_HAIRLINE_ITALIC(x) [UIFont fontWithName:@"Lato-HairlineItalic" size:x]
#define LATO_LIGHT_ITALIC(x) [UIFont fontWithName:@"Lato-LightItalic" size:x]

#define LATO_HEAVY(x) [UIFont fontWithName:@"Lato-Heavy" size:x]
#define LATO_HEAVY_ITALIC(x) [UIFont fontWithName:@"Lato-HeavyItalic" size:x]
#define LATO_MEDIUM(x) [UIFont fontWithName:@"Lato-Medium" size:x]
#define LATO_MEDIUM_ITALIC(x) [UIFont fontWithName:@"Lato-MediumItalic" size:x]
#define LATO_SEMIBOLD(x) [UIFont fontWithName:@"Lato-Semibold" size:x]
#define LATO_SEMIBOLD_ITALIC(x) [UIFont fontWithName:@"Lato-SemiboldItalic" size:x]
#define LATO_THIN(x) [UIFont fontWithName:@"Lato-Thin" size:x]
#define LATO_THIN_ITALIC(x) [UIFont fontWithName:@"Lato-ThinItalic" size:x]

//-------------------------------------------------------------------------
// Custom Contants
#define APP_NAME        @"ParkPanda"
#define FACEBOOK_APP_ID @"1190715200980143"      // FaceBook App ID
#define APP_ID          @"com.adnet.FreePark"   // BundleID


#define TOPBAR_BG_COLOR   RGB(1, 144, 200)
#define STATUS_BAR_COLOR  TOPBAR_BG_COLOR
#define VIEW_BG_COLOR     RGB(244, 243, 237)
#define DETAIL_BG_COLOR   RGB(21, 25, 36)

#endif /* FreeParkDefine_h */
