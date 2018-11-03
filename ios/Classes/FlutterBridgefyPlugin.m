#import "FlutterBridgefyPlugin.h"
#import <BFTransmitter/BFTransmitter.h>

@implementation FlutterBridgefyPlugin {
    BFTransmitter *transmitter;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {

  FlutterMethodChannel* methodChannel =
      [FlutterMethodChannel methodChannelWithName:@"flutter_bridgefy"
            binaryMessenger:[registrar messenger]];

  FlutterEventChannel *eventChannel =
       [FlutterEventChannel eventChannelWithName:@"flutter_bridgefy_result"
            binaryMessenger:[registrar messenger]];
  
  FlutterBridgefyPlugin* instance = [[FlutterBridgefyPlugin alloc] init];

  [registrar addApplicationDelegate:instance];
  [registrar addMethodCallDelegate:instance channel:methodChannel];
  [eventChannel setStreamHandler:instance];
}

FlutterEventSink _eventSink;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [BFTransmitter setLogLevel:BFLogLevelTrace];

    return YES;
}

// ---------------------------------------------------
// MARK: - MethodCallDelegate for FlutterMethodChannel
// ---------------------------------------------------
- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"init" isEqualToString:call.method]){
        NSLog(@"Method:init");
        transmitter = [[BFTransmitter alloc] initWithApiKey:call.arguments];
        result(nil);
    } else if ([@"start" isEqualToString:call.method]){
        NSLog(@"Method:start");
        transmitter.delegate = self;
        [transmitter start];
        result(nil);
    } else if ([@"backgroundModeEnabled" isEqualToString:call.method]){
        NSLog(@"Method:backgroundModeEnabled");
        if(call.arguments!=nil){
            transmitter.backgroundModeEnabled = [call.arguments boolValue];
        }
        result(nil);
    } else if ([@"stop" isEqualToString:call.method]){
        NSLog(@"Method:stop");
        [transmitter stop];
        result(nil);
    } else if ([@"getActivePeers" isEqualToString:call.method]){
        NSLog(@"Method:getActivePeers");
        result(transmitter.activePeers);
    } else if ([@"getCurrentUser" isEqualToString:call.method]){
        NSLog(@"Method:getCurrentUser");
        result(transmitter.currentUser);
    } else if ([@"getLocalPublicKey" isEqualToString:call.method]){
        NSLog(@"Method:getLocalPublicKey");
        result(transmitter.localPublicKey);
    } else if ([@"hasSession" isEqualToString:call.method]){
        NSLog(@"Method:hasSession");
        result(@(transmitter.hasSession));
    } else if ([@"isStarted" isEqualToString:call.method]){
        NSLog(@"Method:isStarted");
        result(@(transmitter.isStarted));
    } else if ([@"getNetworkStatus" isEqualToString:call.method]){
        NSLog(@"Method:getNetworkStatus");
        result(@(transmitter.networkStatus));
    } else if ([@"backgroundModeEnabled" isEqualToString:call.method]){
        NSLog(@"Method:backgroundModeEnabled");
        if(call.arguments!=nil){
            transmitter.backgroundModeEnabled = [call.arguments boolValue];
        }
        result(nil);
    } else if ([@"isBackgroundModeEnabled" isEqualToString:call.method]){
        NSLog(@"Method:isBackgroundModeEnabled");
        result(@(transmitter.isBackgroundModeEnabled));
    } else if ([@"broadcastReceptionEnabled" isEqualToString:call.method]){
        NSLog(@"Method:broadcastReceptionEnabled");
        if(call.arguments!=nil){
            transmitter.broadcastReceptionEnabled = [call.arguments boolValue];
        }
        result(nil);
    } else if ([@"isBroadcastReceptionEnabled" isEqualToString:call.method]){
        NSLog(@"Method:isBroadcastReceptionEnabled");
        result(@(transmitter.isBroadcastReceptionEnabled));
    } else if ([@"sendDictionary" isEqualToString:call.method]){
        NSLog(@"Method:sendDictionary");
        if(call.arguments!=nil){
            BFSendingOption options = (BFSendingOptionDirectTransmission | BFSendingOptionEncrypted);
            NSError *error;
            
            [transmitter sendDictionary:call.arguments[@"dictionary"]
                                    toUser:call.arguments[@"user"]
                                    options:options
                                    error:&error];
            
            if (error)
            {
                NSLog(@"Error %@", error.localizedDescription);
            }
        }
        result(nil);
    } else if ([@"sendData" isEqualToString:call.method]){
        NSLog(@"Method:sendData");
        if(call.arguments!=nil){
            BFSendingOption options = (BFSendingOptionDirectTransmission | BFSendingOptionEncrypted);
            NSError *error;
            
            [transmitter sendData:call.arguments[@"data"]
                            toUser:call.arguments[@"user"]
                            options:options
                            error:&error];
            
            if (error)
            {
                NSLog(@"Error %@", error.localizedDescription);
            }
        }
        result(nil);
    } else if ([@"sendDictionaryWithData" isEqualToString:call.method]){
        NSLog(@"Method:sendDictionaryWithData");
        if(call.arguments!=nil){
            BFSendingOption options = (BFSendingOptionDirectTransmission | BFSendingOptionEncrypted);
            NSError *error;
            
            [transmitter sendDictionary:call.arguments[@"dictionary"]
                                    withData:call.arguments[@"data"]
                                    toUser:call.arguments[@"user"]
                                    options:options
                                    error:&error];
            
            if (error)
            {
                NSLog(@"Error %@", error.localizedDescription);
            }
        }
        result(nil);
    } else if ([@"isUserAvailable" isEqualToString:call.method]){
        NSLog(@"Method:isUserAvailable");
        result(@"[transmitter isUserAvailable:call.arguments]");
    } else if ([@"isSecureConnection" isEqualToString:call.method]){
        NSLog(@"Method:isSecureConnection");
        result(@"[transmitter isSecureConnection:call.arguments]");
    } else if ([@"establishSecureConnection" isEqualToString:call.method]){
        NSLog(@"Method:establishSecureConnection");
        NSError *error;
        [transmitter establishSecureConnection:call.arguments
                                         error:&error];
        if (error)
        {
            NSLog(@"Error %@", error);
        }
        result(nil);
    } else if ([@"destroySession" isEqualToString:call.method]){
        NSLog(@"Method:destroySession");
        [transmitter destroySession];
        result(nil);
    } else if ([@"saveState" isEqualToString:call.method]){
        NSLog(@"Method:saveState");
        [transmitter saveState];
        result(nil);
    } else if ([@"savePublicKey" isEqualToString:call.method]){
        NSLog(@"Method:savePublicKey");
        [transmitter savePublicKey:call.arguments[@"key"]
                        forUser:call.arguments[@"user"]];
        result(nil);
    } else if ([@"existsKeyForUser" isEqualToString:call.method]){
        NSLog(@"Method:savePublicKey");
        result(@"[transmitter existsKeyForUser:call.arguments]");
    } else if ([@"getsecureConnectionExpirationLimit" isEqualToString:call.method]){
        NSLog(@"Method:getsecureConnectionExpirationLimit");
        result(@"[transmitter secureConnectionExpirationLimit]");
    } else if ([@"setSecureConnectionExpirationLimit" isEqualToString:call.method]){
        NSLog(@"Method:setSecureConnectionExpirationLimit");
        result(@"[transmitter secureConnectionExpirationLimit:call.arguments]");
    } else {
    result(FlutterMethodNotImplemented);
  }
}

// ---------------------------------------------
// MARK: - BridgefyDelegate
// ---------------------------------------------
- (void)transmitter:(BFTransmitter *)transmitter didSendDirectPacket:(NSString *)packetID
{
    //A direct message was sent
    NSLog(@"Event: Send Direct Packet %@.", packetID);
}
- (void)transmitter:(BFTransmitter *)transmitter didFailForPacket:(NSString *)packetID error:(NSError * _Nullable)error
{
    //A direct message transmission failed.
    NSLog(@"Event: Fail For Packets %@.", error);
}
- (void)transmitter:(BFTransmitter *)transmitter
didReceiveDictionary:(NSDictionary<NSString *, id> * _Nullable) dictionary
           withData:(NSData * _Nullable)data
           fromUser:(NSString *)user
           packetID:(NSString *)packetID
          broadcast:(BOOL)broadcast
               mesh:(BOOL)mesh
{
    // A dictionary was received by BFTransmitter.
    
}
- (void)transmitter:(BFTransmitter *)transmitter didDetectConnectionWithUser:(NSString *)user
{
    //A connection was detected (no necessarily secure)
    NSLog(@"Event: Detect Connection With User %@.", user);
}
- (void)transmitter:(BFTransmitter *)transmitter didDetectDisconnectionWithUser:(NSString *)user
{
    // // A disconnection was detected.
    NSLog(@"Event: Detect Disconnection With User %@.", user);
}
- (void)transmitter:(BFTransmitter *)transmitter didFailAtStartWithError:(NSError *)error
{
    NSLog(@"Event: An error occurred at start: %@", error.localizedDescription);
}
- (void)transmitter:(BFTransmitter *)transmitter meshDidAddPacket:(NSString *)packetID
{
    //Packet added to mesh
    NSLog(@"Event: Mesh Did Add Packet %@.", packetID);
}

- (void)transmitter:(BFTransmitter *)transmitter didReachDestinationForPacket:( NSString *)packetID
{
    //Mesh packet reached destiny (no always invoked)
    NSLog(@"Event: Reach Destination For Packet %@.", packetID);
}

- (void)transmitter:(BFTransmitter *)transmitter meshDidStartProcessForPacket:( NSString *)packetID
{
    //A message entered in the mesh process.
    NSLog(@"Event: Start Process For Packet %@.", packetID);
}
- (void)transmitter:(BFTransmitter *)transmitter meshDidDiscardPackets:(NSArray<NSString *> *)packetIDs
{
    //A mesh message was discared and won't still be transmitted.
    NSLog(@"Event: Mesh Discard Packets %@.", packetIDs);
}
- (void)transmitter:(BFTransmitter *)transmitter meshDidRejectPacketBySize:(NSString *)packetID
{
    NSLog(@"The packet %@ was rejected from mesh because it exceeded the limit size.", packetID);
}
- (void)transmitter:(BFTransmitter *)transmitter didOccurEvent:(BFEvent)event description:(NSString *)description
{
    NSLog(@"Event: reported %@", description);
}
-(void)transmitter:(BFTransmitter *)transmitter didDetectSecureConnectionWithUser:(nonnull NSString *)user
{
    // A secure connection was detected,
    // A secure connection has encryption capabilities.
    NSLog(@"Event: Detect Secure Connection With User %@.", user);
}
-(BOOL)transmitter:(BFTransmitter *)transmitter shouldConnectSecurelyWithUser:(NSString *)user
{
    return YES; //if YES establish connection with encryption capacities.
}
- (void)transmitterNeedsInterfaceActivation:(BFTransmitter *)transmitter;
{
    // This method is invoked when the transmitter is running but there isn't any network interface
    // to use.
}
- (void)transmitterDidDetectAnotherInterfaceStarted:(BFTransmitter *)transmitter;
{
    // Method invoked when there is another instance already running.
}


// ---------------------------------------------
// MARK: - StreamHandler for FlutterEventChannel
// ---------------------------------------------
- (FlutterError *)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)eventSink {
    _eventSink = eventSink;
    return nil;
}

- (FlutterError *)onCancelWithArguments:(id)arguments {
    _eventSink = nil;
    return nil;
}
@end
