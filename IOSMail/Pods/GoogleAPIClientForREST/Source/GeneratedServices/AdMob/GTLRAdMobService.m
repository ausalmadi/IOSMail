// NOTE: This file was generated by the ServiceGenerator.

// ----------------------------------------------------------------------------
// API:
//   AdMob API (admob/v1)
// Description:
//   The Google AdMob API lets you programmatically get reports on earnings.
// Documentation:
//   https://developers.google.com/admob/api/

#import "GTLRAdMob.h"

// ----------------------------------------------------------------------------
// Authorization scope

NSString * const kGTLRAuthScopeAdMobReport = @"https://www.googleapis.com/auth/admob.report";

// ----------------------------------------------------------------------------
//   GTLRAdMobService
//

@implementation GTLRAdMobService

- (instancetype)init {
  self = [super init];
  if (self) {
    // From discovery.
    self.rootURLString = @"https://admob.googleapis.com/";
    self.batchPath = @"batch";
    self.prettyPrintQueryParameterNames = @[ @"prettyPrint" ];
  }
  return self;
}

@end
