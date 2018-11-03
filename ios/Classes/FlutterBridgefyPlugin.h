#import <Flutter/Flutter.h>
#import <BFTransmitter/BFTransmitter.h>

@interface FlutterBridgefyPlugin : NSObject<FlutterPlugin, BFTransmitterDelegate, FlutterStreamHandler>
@end
