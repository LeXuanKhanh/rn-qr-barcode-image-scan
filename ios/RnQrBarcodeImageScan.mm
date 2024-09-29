#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(RnQrBarcodeImageScan, NSObject)

RCT_EXTERN_METHOD(scanFromPath:(NSString*)path
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

@end
