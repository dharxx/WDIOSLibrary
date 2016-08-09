//
//  WDIOSMapViewController.m
//  WDIOSLibrary
//
//  Created by Dhanu Saksrisathaporn on 8/3/2559 BE.
//  Copyright © 2559 Dhanu Saksrisathaporn. All rights reserved.
//

#import "WDIOSMapViewController.h"
#import <MQTTKit/MQTTKit.h>

@import GoogleMaps;
@interface WDIOSMapViewController ()<GMSMapViewDelegate>
{
    
    NSString *clientID;
    MQTTClient *client;
}
@property GMSMarker *marker;
@end

@implementation WDIOSMapViewController


static NSString *DEFAULT_HOST = @"46.101.135.176";


- (void)settingSession
{
    clientID = @"mobileTest";
    clientID = [clientID stringByAppendingString:@([NSDate date].timeIntervalSince1970).stringValue];
    client = [[MQTTClient alloc] initWithClientId:clientID];
    
    __weak typeof(self) weakSelf = self;
    [client setMessageHandler:^(MQTTMessage *message) {
        
        NSDictionary *d = [NSJSONSerialization JSONObjectWithData:message.payload options:0 error:nil];
        NSString *topic = message.topic;
//        NSLog(@"%@ received message %@", topic ,d);
        NSString *messageString = d[@"message"];
        if (messageString.length > 1 && [UIApplication sharedApplication].applicationState == UIApplicationStateBackground)
        {
            UILocalNotification *noti = [[UILocalNotification alloc] init];
            //                    noti.fireDate =  [NSDate dateWithTimeIntervalSinceNow:1];
            noti.alertBody = messageString ;
            noti.timeZone = [NSTimeZone defaultTimeZone];
            noti.soundName = @"mayuyu.aiff";
            [[UIApplication sharedApplication] scheduleLocalNotification:noti];
        }
        if ([[topic lastPathComponent] isEqualToString:@"moveTo"]) {
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([d[@"lat"] doubleValue], [d[@"lon"] doubleValue]);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                weakSelf.marker.position = coordinate;
                NSLog(@"%@",d[@"cID"]);
            });
        }
    }];
    
    [self connectToHost:DEFAULT_HOST];
}
- (void)connectToHost:(NSString *)host
{
    [client connectToHost:host
        completionHandler:^(MQTTConnectionReturnCode code) {
            if (code == ConnectionAccepted) {
                // when the client is connected, subscribe to the topic to receive message.
                [client subscribe:@"mainChannel/#" withQos:ExactlyOnce completionHandler:^(NSArray *grantedQos) {
                    NSLog(@"%@",grantedQos);
                }];
            }
        }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self settingSession];
    [GMSServices provideAPIKey:@"AIzaSyAX0mg0vCHNMwW9bMndgtLT2UwUDRoY1aM"];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.868
                                                            longitude:151.2086
                                                                 zoom:6];
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.delegate = self;
    self.view = mapView;
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = camera.target;
    marker.snippet = @"Hello World";
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.map = mapView;
    self.marker = marker;
}
- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
    CGPoint locationInView = [mapView.projection pointForCoordinate:coordinate]; // capitalize the V
//    marker.position = coordinate;
    NSLog(@"%f %f\n%lf %lf",locationInView.x,locationInView.y,coordinate.latitude,coordinate.longitude);
    
    NSDictionary *d = @{
                        @"lat":@(coordinate.latitude),
                        @"lon":@(coordinate.longitude),
                        @"cID":clientID,
                        @"message":@"Change Current Position"
                        };
    NSData *data = [NSJSONSerialization dataWithJSONObject:d options:0 error:nil];
    
    // connect to the MQTT server
    [client publishData:data toTopic:@"mainChannel/moveTo" withQos:AtLeastOnce retain:NO completionHandler:^(int mid) {
        NSLog(@"message (%@) has been delivered",d);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
