/* Copyright (c) 2016 Google Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

//
//  GTLGmailListHistoryResponse.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   Gmail API (gmail/v1)
// Description:
//   Access Gmail mailboxes including sending user email.
// Documentation:
//   https://developers.google.com/gmail/api/
// Classes:
//   GTLGmailListHistoryResponse (0 custom class methods, 3 custom properties)

#import "GTLGmailListHistoryResponse.h"

#import "GTLGmailHistory.h"

// ----------------------------------------------------------------------------
//
//   GTLGmailListHistoryResponse
//

@implementation GTLGmailListHistoryResponse
@dynamic history, historyId, nextPageToken;

+ (NSDictionary *)arrayPropertyToClassMap {
  NSDictionary *map = @{
    @"history" : [GTLGmailHistory class]
  };
  return map;
}

@end