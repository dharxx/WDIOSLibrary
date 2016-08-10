//
//  JWT.h
//  JWT
//
//  Created by Klaas Pieter Annema on 31-05-13.
//  Copyright (c) 2013 Karma. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JWTAlgorithm.h"
#import "JWTClaimsSet.h"

typedef NS_ENUM(NSInteger, JWTError) {
    JWTInvalidFormatError = -100,
    JWTUnsupportedAlgorithmError,
    JWTInvalidSignatureError,
    JWTNoPayloadError,
    JWTNoHeaderError,
    JWTEncodingHeaderError,
    JWTEncodingPayloadError,
    JWTEncodingSigningError,
    JWTClaimsSetVerificationFailed,
    JWTInvalidSegmentSerializationError,
    JWTUnspecifiedAlgorithmError,
    JWTDecodingHeaderError,
    JWTDecodingPayloadError,
};

@class JWTBuilder;
@interface JWT : NSObject

#pragma mark - Encode
+ (NSString *)encodeClaimsSet:(JWTClaimsSet *)theClaimsSet withSecret:(NSString *)theSecret __attribute__((deprecated));
+ (NSString *)encodeClaimsSet:(JWTClaimsSet *)theClaimsSet withSecret:(NSString *)theSecret algorithm:(id<JWTAlgorithm>)theAlgorithm __attribute__((deprecated));

+ (NSString *)encodePayload:(NSDictionary *)thePayload withSecret:(NSString *)theSecret __attribute__((deprecated));
+ (NSString *)encodePayload:(NSDictionary *)thePayload withSecret:(NSString *)theSecret algorithm:(id<JWTAlgorithm>)theAlgorithm __attribute__((deprecated));

+ (NSString *)encodePayload:(NSDictionary *)thePayload withSecret:(NSString *)theSecret withHeaders:(NSDictionary *)theHeaders algorithm:(id<JWTAlgorithm>)theAlgorithm __attribute__((deprecated));

+ (NSString *)encodePayload:(NSDictionary *)thePayload withSecret:(NSString *)theSecret withHeaders:(NSDictionary *)theHeaders algorithm:(id<JWTAlgorithm>)theAlgorithm withError:(NSError * __autoreleasing *)theError __attribute__((deprecated));

//Will be deprecated in later releases
#pragma mark - Decode

/**
 Decodes a JWT and returns the decoded Header and Payload
 @param theMessage The encoded JWT
 @param theSecret The verification key to use for validating the JWT signature
 @param theTrustedClaimsSet The JWTClaimsSet to use for verifying the JWT values
 @param theError Error pointer, if there is an error decoding the message, upon return contains an NSError object that describes the problem.
 @param theAlgorithmName The name of the algorithm to use for verifying the signature. Required, unless skipping verification
 @param theForcedOption BOOL indicating if verifying the JWT signature should be skipped. Should only be used for debugging
 @return A dictionary containing the header and payload dictionaries. Keyed to "header" and "payload", respectively. Or nil if an error occurs.
 */
+ (NSDictionary *)decodeMessage:(NSString *)theMessage withSecret:(NSString *)theSecret withTrustedClaimsSet:(JWTClaimsSet *)theTrustedClaimsSet withError:(NSError *__autoreleasing *)theError withForcedAlgorithmByName:(NSString *)theAlgorithmName withForcedOption:(BOOL)theForcedOption __attribute__((deprecated));

/**
 Decodes a JWT and returns the decoded Header and Payload
 @param theMessage The encoded JWT
 @param theSecret The verification key to use for validating the JWT signature
 @param theTrustedClaimsSet The JWTClaimsSet to use for verifying the JWT values
 @param theError Error pointer, if there is an error decoding the message, upon return contains an NSError object that describes the problem.
 @param theAlgorithmName The name of the algorithm to use for verifying the signature. Required.
 @return A dictionary containing the header and payload dictionaries. Keyed to "header" and "payload", respectively. Or nil if an error occurs.
 */
+ (NSDictionary *)decodeMessage:(NSString *)theMessage withSecret:(NSString *)theSecret withTrustedClaimsSet:(JWTClaimsSet *)theTrustedClaimsSet withError:(NSError *__autoreleasing *)theError withForcedAlgorithmByName:(NSString *)theAlgorithmName __attribute__((deprecated));

/**
 Decodes a JWT and returns the decoded Header and Payload.
 
 Uses the JWTAlgorithmHS512 for decoding
 
 @param theMessage The encoded JWT
 @param theSecret The verification key to use for validating the JWT signature
 @param theTrustedClaimsSet The JWTClaimsSet to use for verifying the JWT values
 @param theError Error pointer, if there is an error decoding the message, upon return contains an NSError object that describes the problem.
 @param theForcedOption BOOL indicating if verifying the JWT signature should be skipped. Should only be used for debugging
 @return A dictionary containing the header and payload dictionaries. Keyed to "header" and "payload", respectively. Or nil if an error occurs.
 */
+ (NSDictionary *)decodeMessage:(NSString *)theMessage withSecret:(NSString *)theSecret withTrustedClaimsSet:(JWTClaimsSet *)theTrustedClaimsSet withError:(NSError *__autoreleasing *)theError withForcedOption:(BOOL)theForcedOption __attribute__((deprecated));

/**
 Decodes a JWT and returns the decoded Header and Payload
 @param theMessage The encoded JWT
 @param theSecret The verification key to use for validating the JWT signature
 @param theError Error pointer, if there is an error decoding the message, upon return contains an NSError object that describes the problem.
 @param theAlgorithmName The name of the algorithm to use for verifying the signature. Required, unless skipping verification
 @param skipVerification BOOL indicating if verifying the JWT signature should be skipped. Should only be used for debugging
 @return A dictionary containing the header and payload dictionaries. Keyed to "header" and "payload", respectively. Or nil if an error occurs.
 */
+ (NSDictionary *)decodeMessage:(NSString *)theMessage withSecret:(NSString *)theSecret withError:(NSError *__autoreleasing *)theError withForcedAlgorithmByName:(NSString *)theAlgorithmName skipVerification:(BOOL)skipVerification __attribute__((deprecated));

/**
 Decodes a JWT and returns the decoded Header and Payload
 @param theMessage The encoded JWT
 @param theSecret The verification key to use for validating the JWT signature
 @param theError Error pointer, if there is an error decoding the message, upon return contains an NSError object that describes the problem.
 @param theAlgorithmName The name of the algorithm to use for verifying the signature. Required.
 @return A dictionary containing the header and payload dictionaries. Keyed to "header" and "payload", respectively. Or nil if an error occurs.
 */
+ (NSDictionary *)decodeMessage:(NSString *)theMessage withSecret:(NSString *)theSecret withError:(NSError *__autoreleasing *)theError withForcedAlgorithmByName:(NSString *)theAlgorithmName __attribute__((deprecated));

/**
 Decodes a JWT and returns the decoded Header and Payload
 
 Uses the JWTAlgorithmHS512 for decoding
 
 @param theMessage The encoded JWT
 @param theSecret The verification key to use for validating the JWT signature
 @param theError Error pointer, if there is an error decoding the message, upon return contains an NSError object that describes the problem.
 @param theForcedOption BOOL indicating if verifying the JWT signature should be skipped.
 @return A dictionary containing the header and payload dictionaries. Keyed to "header" and "payload", respectively. Or nil if an error occurs.
 */
+ (NSDictionary *)decodeMessage:(NSString *)theMessage withSecret:(NSString *)theSecret withError:(NSError *__autoreleasing *)theError withForcedOption:(BOOL)theForcedOption __attribute__((deprecated));

/**
 Decodes a JWT and returns the decoded Header and Payload.
 Uses the JWTAlgorithmHS512 for decoding
 @param theMessage The encoded JWT
 @param theSecret The verification key to use for validating the JWT signature
 @param theError Error pointer, if there is an error decoding the message, upon return contains an NSError object that describes the problem.
 @return A dictionary containing the header and payload dictionaries. Keyed to "header" and "payload", respectively. Or nil if an error occurs.
 */
+ (NSDictionary *)decodeMessage:(NSString *)theMessage withSecret:(NSString *)theSecret withError:(NSError * __autoreleasing *)theError __attribute__((deprecated));

/**
 Decodes a JWT and returns the decoded Header and Payload.
 Uses the JWTAlgorithmHS512 for decoding
 @param theMessage The encoded JWT
 @param theSecret The verification key to use for validating the JWT signature
 @return A dictionary containing the header and payload dictionaries. Keyed to "header" and "payload", respectively. Or nil if an error occurs. 
 */
+ (NSDictionary *)decodeMessage:(NSString *)theMessage withSecret:(NSString *)theSecret __attribute__((deprecated));

#pragma mark - Builder
+ (JWTBuilder *)encodePayload:(NSDictionary *)payload;
+ (JWTBuilder *)encodeClaimsSet:(JWTClaimsSet *)claimsSet;
+ (JWTBuilder *)decodeMessage:(NSString *)message;
@end

@interface JWTBuilder : NSObject 

+ (JWTBuilder *)encodePayload:(NSDictionary *)payload;
+ (JWTBuilder *)encodeClaimsSet:(JWTClaimsSet *)claimsSet;
+ (JWTBuilder *)decodeMessage:(NSString *)message;

/**
 The JWT in it's encoded form. Will be decoded and verified
 */
@property (copy, nonatomic, readonly) NSString *jwtMessage;

/**
 The payload dictionary to encode
 */
@property (copy, nonatomic, readonly) NSDictionary *jwtPayload;

/**
 The header dictionary to encode
 */
@property (copy, nonatomic, readonly) NSDictionary *jwtHeaders;

/**
 The expected JWTClaimsSet to compare against a decoded JWT
 */
@property (copy, nonatomic, readonly) JWTClaimsSet *jwtClaimsSet;

/**
 The verification key to use when encoding/decoding a JWT
 */
@property (copy, nonatomic, readonly) NSString *jwtSecret;

/**
 The verification key to use when encoding/decoding a JWT in data form
 */
@property (copy, nonatomic, readonly) NSData *jwtSecretData;

/**
 The passphrase for the PKCS12 blob, which represents the certificate containing the private key for the RS algorithms.
 */
@property (copy, nonatomic, readonly) NSString *jwtPrivateKeyCertificatePassphrase;

/**
 Contains the error that occured during an operation, or nil if no error occured
 */
@property (copy, nonatomic, readonly) NSError *jwtError;

/**
 The <JWTAlgorithm> to use for encoding a JWT
 */
@property (strong, nonatomic, readonly) id<JWTAlgorithm> jwtAlgorithm;

/**
 The algorithm name to use for decoding the JWT. Required unless force decode is true
 */
@property (copy, nonatomic, readonly) NSString *jwtAlgorithmName;

/**
 The force decode option. If set to true, a JWT won't be validated before decoding.
 Should only be used for debugging
 */
@property (copy, nonatomic, readonly) NSNumber *jwtOptions;

/*
 Optional algorithm name whitelist. If non-null, a JWT can only be decoded using an algorithm
 specified on this list.
 */
@property (copy, nonatomic, readonly) NSSet *algorithmWhitelist;

/**
 Sets jwtMessage and returns the JWTBuilder to allow for method chaining
 */
@property (copy, nonatomic, readonly) JWTBuilder *(^message)(NSString *message);

/**
 Sets jwtPayload and returns the JWTBuilder to allow for method chaining
 */
@property (copy, nonatomic, readonly) JWTBuilder *(^payload)(NSDictionary *payload);

/**
 Sets jwtHeaders and returns the JWTBuilder to allow for method chaining
 */
@property (copy, nonatomic, readonly) JWTBuilder *(^headers)(NSDictionary *headers);

/**
 Sets jwtClaimsSet and returns the JWTBuilder to allow for method chaining
 */
@property (copy, nonatomic, readonly) JWTBuilder *(^claimsSet)(JWTClaimsSet *claimsSet);

/**
 Sets jwtSecret and returns the JWTBuilder to allow for method chaining
 */
@property (copy, nonatomic, readonly) JWTBuilder *(^secret)(NSString *secret);

/**
 Sets jwtSecretData and returns the JWTBuilder to allow for method chaining
 */
@property (copy, nonatomic, readonly) JWTBuilder *(^secretData)(NSData *secretData);

/**
 Sets jwtPrivateKeyCertificatePassphrase and returns the JWTBuilder to allow for method chaining
 */
@property (copy, nonatomic, readonly) JWTBuilder *(^privateKeyCertificatePassphrase)(NSString *privateKeyCertificatePassphrase);

/**
 Sets jwtAlgorithm and returns the JWTBuilder to allow for method chaining
 */
@property (copy, nonatomic, readonly) JWTBuilder *(^algorithm)(id<JWTAlgorithm>algorithm);

/**
 Sets jwtAlgorithmName and returns the JWTBuilder to allow for method chaining
 */
@property (copy, nonatomic, readonly) JWTBuilder *(^algorithmName)(NSString *algorithmName);

/**
 Sets jwtOptions and returns the JWTBuilder to allow for method chaining
 */
@property (copy, nonatomic, readonly) JWTBuilder *(^options)(NSNumber *options);

/**
 Sets algorithmWhitelist and returns the JWTBuilder to allow for method chaining
 */
@property (copy, nonatomic, readonly) JWTBuilder *(^whitelist)(NSArray *whitelist);

/**
 Creates the encoded JWT string based on the currently set properties, or nil if an
 error occured
 */
@property (copy, nonatomic, readonly) NSString *encode;

/**
 Decodes and returns the JWT as a dictionary, based on the JWTBuilder's currently set
 properties, or nil, if an error occured.
 */
@property (copy, nonatomic, readonly) NSDictionary *decode;

@end