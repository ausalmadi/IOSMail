// NOTE: This file was generated by the ServiceGenerator.

// ----------------------------------------------------------------------------
// API:
//   Gmail API (gmail/v1)
// Description:
//   The Gmail API lets you view and manage Gmail mailbox data like threads,
//   messages, and labels.
// Documentation:
//   https://developers.google.com/gmail/api/

#if SWIFT_PACKAGE || GTLR_USE_MODULAR_IMPORT
  @import GoogleAPIClientForRESTCore;
#elif GTLR_BUILT_AS_FRAMEWORK
  #import "GTLR/GTLRService.h"
#else
  #import "GTLRService.h"
#endif

#if GTLR_RUNTIME_VERSION != 3000
#error This file was generated by a different version of ServiceGenerator which is incompatible with this GTLR library source.
#endif

// Generated comments include content from the discovery document; avoid them
// causing warnings since clang's checks are some what arbitrary.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

NS_ASSUME_NONNULL_BEGIN

// ----------------------------------------------------------------------------
// Authorization scopes

/**
 *  Authorization scope: Manage drafts and send emails when you interact with
 *  the add-on
 *
 *  Value "https://www.googleapis.com/auth/gmail.addons.current.action.compose"
 */
FOUNDATION_EXTERN NSString * const kGTLRAuthScopeGmailAddonsCurrentActionCompose;
/**
 *  Authorization scope: View your email messages when you interact with the
 *  add-on
 *
 *  Value "https://www.googleapis.com/auth/gmail.addons.current.message.action"
 */
FOUNDATION_EXTERN NSString * const kGTLRAuthScopeGmailAddonsCurrentMessageAction;
/**
 *  Authorization scope: View your email message metadata when the add-on is
 *  running
 *
 *  Value "https://www.googleapis.com/auth/gmail.addons.current.message.metadata"
 */
FOUNDATION_EXTERN NSString * const kGTLRAuthScopeGmailAddonsCurrentMessageMetadata;
/**
 *  Authorization scope: View your email messages when the add-on is running
 *
 *  Value "https://www.googleapis.com/auth/gmail.addons.current.message.readonly"
 */
FOUNDATION_EXTERN NSString * const kGTLRAuthScopeGmailAddonsCurrentMessageReadonly;
/**
 *  Authorization scope: Manage drafts and send emails
 *
 *  Value "https://www.googleapis.com/auth/gmail.compose"
 */
FOUNDATION_EXTERN NSString * const kGTLRAuthScopeGmailCompose;
/**
 *  Authorization scope: Insert mail into your mailbox
 *
 *  Value "https://www.googleapis.com/auth/gmail.insert"
 */
FOUNDATION_EXTERN NSString * const kGTLRAuthScopeGmailInsert;
/**
 *  Authorization scope: Manage mailbox labels
 *
 *  Value "https://www.googleapis.com/auth/gmail.labels"
 */
FOUNDATION_EXTERN NSString * const kGTLRAuthScopeGmailLabels;
/**
 *  Authorization scope: Read, compose, send, and permanently delete all your
 *  email from Gmail
 *
 *  Value "https://mail.google.com/"
 */
FOUNDATION_EXTERN NSString * const kGTLRAuthScopeGmailMailGoogleCom;
/**
 *  Authorization scope: View your email message metadata such as labels and
 *  headers, but not the email body
 *
 *  Value "https://www.googleapis.com/auth/gmail.metadata"
 */
FOUNDATION_EXTERN NSString * const kGTLRAuthScopeGmailMetadata;
/**
 *  Authorization scope: View and modify but not delete your email
 *
 *  Value "https://www.googleapis.com/auth/gmail.modify"
 */
FOUNDATION_EXTERN NSString * const kGTLRAuthScopeGmailModify;
/**
 *  Authorization scope: View your email messages and settings
 *
 *  Value "https://www.googleapis.com/auth/gmail.readonly"
 */
FOUNDATION_EXTERN NSString * const kGTLRAuthScopeGmailReadonly;
/**
 *  Authorization scope: Send email on your behalf
 *
 *  Value "https://www.googleapis.com/auth/gmail.send"
 */
FOUNDATION_EXTERN NSString * const kGTLRAuthScopeGmailSend;
/**
 *  Authorization scope: Manage your basic mail settings
 *
 *  Value "https://www.googleapis.com/auth/gmail.settings.basic"
 */
FOUNDATION_EXTERN NSString * const kGTLRAuthScopeGmailSettingsBasic;
/**
 *  Authorization scope: Manage your sensitive mail settings, including who can
 *  manage your mail
 *
 *  Value "https://www.googleapis.com/auth/gmail.settings.sharing"
 */
FOUNDATION_EXTERN NSString * const kGTLRAuthScopeGmailSettingsSharing;

// ----------------------------------------------------------------------------
//   GTLRGmailService
//

/**
 *  Service for executing Gmail API queries.
 *
 *  The Gmail API lets you view and manage Gmail mailbox data like threads,
 *  messages, and labels.
 */
@interface GTLRGmailService : GTLRService

// No new methods

// Clients should create a standard query with any of the class methods in
// GTLRGmailQuery.h. The query can the be sent with GTLRService's execute
// methods,
//
//   - (GTLRServiceTicket *)executeQuery:(GTLRQuery *)query
//                     completionHandler:(void (^)(GTLRServiceTicket *ticket,
//                                                 id object, NSError *error))handler;
// or
//   - (GTLRServiceTicket *)executeQuery:(GTLRQuery *)query
//                              delegate:(id)delegate
//                     didFinishSelector:(SEL)finishedSelector;
//
// where finishedSelector has a signature of:
//
//   - (void)serviceTicket:(GTLRServiceTicket *)ticket
//      finishedWithObject:(id)object
//                   error:(NSError *)error;
//
// The object passed to the completion handler or delegate method
// is a subclass of GTLRObject, determined by the query method executed.

@end

NS_ASSUME_NONNULL_END

#pragma clang diagnostic pop
