/*
 
 Auto-Generated by the SAP NetWeaver Gateway developer tool for Xcode, Version 2.5.300.0
  
 File: Logger.h
 Abstract: Logger class.
 
 
*/


#import <Foundation/Foundation.h>


#ifndef LOGERROR
#define LOGERROR(msg) \
{ \
[Logger logError:msg withInfo:[NSString stringWithFormat:@"File: %@ Function: %@ Line: %d", \
[[NSString stringWithUTF8String:__FILE__] lastPathComponent], \
[NSString stringWithUTF8String:__PRETTY_FUNCTION__], \
__LINE__]]; \
} 
#endif


#ifndef LOGWARNING
#define LOGWARNING(msg) \
{ \
[Logger logWarning:msg withInfo:[NSString stringWithFormat:@"File: %@ Function: %@ Line: %d", \
[[NSString stringWithUTF8String:__FILE__] lastPathComponent], \
[NSString stringWithUTF8String:__PRETTY_FUNCTION__], \
__LINE__]]; \
} 
#endif


#ifndef LOGNOTICE
#define LOGNOTICE(msg) \
{ \
[Logger logNotice:msg withInfo:[NSString stringWithFormat:@"File: %@ Function: %@ Line: %d", \
[[NSString stringWithUTF8String:__FILE__] lastPathComponent], \
[NSString stringWithUTF8String:__PRETTY_FUNCTION__], \
__LINE__]]; \
} 
#endif


/**
 Logger class
 @remark You should use the LOGx macros as they automatically enhance the log entry with useful information like FILE, FUNCTION and LINE.
*/
@interface Logger : NSObject


/**
 Log message in error level with additional information.
 @param msg Message to log.
 @param info Additional information to include after the message to log (as FUNETION and LINE).
 */
+ (void)logError:(NSString *)msg withInfo:(NSString *)info;

/**
 Log message in warning level with additional information.
 @param msg Message to log.
 @param info Additional information to include after the message to log (as FUNETION and LINE).
 */
+ (void)logWarning:(NSString *)msg withInfo:(NSString *)info;

/**
 Log message in notice level with additional information.
 @param msg Message to log.
 @param info Additional information to include after the message to log (as FUNETION and LINE).
 */
+ (void)logNotice:(NSString *)msg withInfo:(NSString *)info;

/**
 Log message in error level.
 @param msg Message to log.
*/
+ (void)logError:(NSString *)msg ;

/**
 Log message in warning level.
 @param msg Message to log.
*/
+ (void)logWarning:(NSString *)msg;

/**
 Log message in notice level.
 @param msg Message to log.
*/
+ (void)logNotice:(NSString *)msg;

/**
 Enables detailed logging of SDM libraries. Logs messages with level of Debug and higher.
 Detailed logging is disabled by default.
*/
+ (void)enableSDMDetailedLogging;

/**
 Disables detailed logging of SDM libraries. Logs messages with level of Error and higher.
*/
+ (void)disableSDMDetailedLogging;

@end