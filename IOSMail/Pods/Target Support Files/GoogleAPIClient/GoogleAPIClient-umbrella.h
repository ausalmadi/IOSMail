#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "GTLDefines.h"
#import "GTLBatchQuery.h"
#import "GTLBatchResult.h"
#import "GTLDateTime.h"
#import "GTLErrorObject.h"
#import "GTLObject.h"
#import "GTLQuery.h"
#import "GTLRuntimeCommon.h"
#import "GTLService.h"
#import "GTLUploadParameters.h"
#import "GTLBase64.h"
#import "GTLFramework.h"
#import "GTLJSONParser.h"
#import "GTLTargetNamespace.h"
#import "GTLUtilities.h"
#import "GTLGmail.h"
#import "GTLGmailConstants.h"
#import "GTLGmailDraft.h"
#import "GTLGmailHistory.h"
#import "GTLGmailHistoryLabelAdded.h"
#import "GTLGmailHistoryLabelRemoved.h"
#import "GTLGmailHistoryMessageAdded.h"
#import "GTLGmailHistoryMessageDeleted.h"
#import "GTLGmailLabel.h"
#import "GTLGmailListDraftsResponse.h"
#import "GTLGmailListHistoryResponse.h"
#import "GTLGmailListLabelsResponse.h"
#import "GTLGmailListMessagesResponse.h"
#import "GTLGmailListThreadsResponse.h"
#import "GTLGmailMessage.h"
#import "GTLGmailMessagePart.h"
#import "GTLGmailMessagePartBody.h"
#import "GTLGmailMessagePartHeader.h"
#import "GTLGmailProfile.h"
#import "GTLGmailThread.h"
#import "GTLGmailWatchResponse.h"
#import "GTLQueryGmail.h"
#import "GTLServiceGmail.h"

FOUNDATION_EXPORT double GoogleAPIClientVersionNumber;
FOUNDATION_EXPORT const unsigned char GoogleAPIClientVersionString[];

