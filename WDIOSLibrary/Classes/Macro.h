//
//  Macro.h
//  Weinkeller
//
//  Created by Dhanu Saksrisathaporn on 6/24/2559 BE.
//  Copyright © 2559 Dhanu Saksrisathaporn. All rights reserved.
//


#define CAT(a,b) a##b

#define defaultManagerName(class)  CAT(default,class)

//add this to .h
#define defaultManagerPrototype(class) +(instancetype)defaultManagerName(class)

//add this to .m
#define defaultManagerMethod(class)           \
defaultManagerPrototype(class) {                \
static class *sharedManager = nil;   \
static dispatch_once_t onceToken;               \
dispatch_once(&onceToken, ^{                        \
sharedManager = [[self alloc] init];                \
});                                                                         \
return sharedManager;                                           \
}

#define manager(class) [class defaultManagerName(class)]
