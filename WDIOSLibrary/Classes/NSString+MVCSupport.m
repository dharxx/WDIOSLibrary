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

- (NSString *)urlencode {
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]];
}
- (NSString *)urlencodeCustom {
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[self UTF8String];
    int sourceLen = strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}
@end
