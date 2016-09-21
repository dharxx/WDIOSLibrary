//
//  NSString+MVCSupport.m
//  Pods
//
//  Created by Dhanu Saksrisathaporn on 9/21/2559 BE.
//
//

#import "NSString+MVCSupport.h"

@implementation NSString (MVCSupport)
- (NSUInteger)occurrenceCountOfCharacter:(UniChar)character
{
    CFStringRef selfAsCFStr = (__bridge CFStringRef)self;
    
    CFStringInlineBuffer inlineBuffer;
    CFIndex length = CFStringGetLength(selfAsCFStr);
    CFStringInitInlineBuffer(selfAsCFStr, &inlineBuffer, CFRangeMake(0, length));
    
    NSUInteger counter = 0;
    
    for (CFIndex i = 0; i < length; i++) {
        UniChar c = CFStringGetCharacterFromInlineBuffer(&inlineBuffer, i);
        if (c == character) counter += 1;
    }
    
    return counter;
}
@end
