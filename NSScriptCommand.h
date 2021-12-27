//
//  NSScriptCommand.h
//  CatalystAppleScript
//
//  Created by Steven Troughton-Smith on 05/06/2021.
//
//	NSScriptCommand is not exposed to Catalyst
//	which makes it difficult to subclass directly
//	in Swift. So let's define it here

#ifndef NSScriptCommand_h
#define NSScriptCommand_h

@import Foundation;

#if __IPHONE_OS_VERSION_MAX_ALLOWED <= 140000
@interface NSScriptCommand : NSObject
-(void)performDefaultImplementation;
@end
#endif

#endif /* NSScriptCommand_h */
