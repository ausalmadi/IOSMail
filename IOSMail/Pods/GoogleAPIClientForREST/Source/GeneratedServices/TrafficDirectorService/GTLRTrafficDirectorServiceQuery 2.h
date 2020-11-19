// NOTE: This file was generated by the ServiceGenerator.

// ----------------------------------------------------------------------------
// API:
//   Traffic Director API (trafficdirector/v2)
// Documentation:
//   https://www.envoyproxy.io/docs/envoy/latest/configuration/overview/v2_overview#management-server

#if SWIFT_PACKAGE || GTLR_USE_MODULAR_IMPORT
  @import GoogleAPIClientForRESTCore;
#elif GTLR_BUILT_AS_FRAMEWORK
  #import "GTLR/GTLRQuery.h"
#else
  #import "GTLRQuery.h"
#endif

#if GTLR_RUNTIME_VERSION != 3000
#error This file was generated by a different version of ServiceGenerator which is incompatible with this GTLR library source.
#endif

@class GTLRTrafficDirectorService_ClientStatusRequest;

// Generated comments include content from the discovery document; avoid them
// causing warnings since clang's checks are some what arbitrary.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

NS_ASSUME_NONNULL_BEGIN

/**
 *  Parent class for other Traffic Director Service query classes.
 */
@interface GTLRTrafficDirectorServiceQuery : GTLRQuery

/** Selector specifying which fields to include in a partial response. */
@property(nonatomic, copy, nullable) NSString *fields;

@end

/**
 *  GTLRTrafficDirectorServiceQuery_DiscoveryClientStatus
 *
 *  Method: trafficdirector.discovery.client_status
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeTrafficDirectorServiceCloudPlatform
 */
@interface GTLRTrafficDirectorServiceQuery_DiscoveryClientStatus : GTLRTrafficDirectorServiceQuery
// Previous library name was
//   +[GTLQueryTrafficDirectorService queryForDiscoveryClientStatusWithObject:]

/**
 *  Fetches a @c GTLRTrafficDirectorService_ClientStatusResponse.
 *
 *  @param object The @c GTLRTrafficDirectorService_ClientStatusRequest to
 *    include in the query.
 *
 *  @return GTLRTrafficDirectorServiceQuery_DiscoveryClientStatus
 */
+ (instancetype)queryWithObject:(GTLRTrafficDirectorService_ClientStatusRequest *)object;

@end

NS_ASSUME_NONNULL_END

#pragma clang diagnostic pop
