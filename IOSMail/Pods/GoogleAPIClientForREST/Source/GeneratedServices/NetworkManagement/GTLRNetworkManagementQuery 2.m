// NOTE: This file was generated by the ServiceGenerator.

// ----------------------------------------------------------------------------
// API:
//   Network Management API (networkmanagement/v1)
// Description:
//   The Network Management API provides a collection of network performance
//   monitoring and diagnostic capabilities.
// Documentation:
//   https://cloud.google.com/

#import "GTLRNetworkManagementQuery.h"

#import "GTLRNetworkManagementObjects.h"

@implementation GTLRNetworkManagementQuery

@dynamic fields;

@end

@implementation GTLRNetworkManagementQuery_ProjectsLocationsGet

@dynamic name;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v1/{+name}";
  GTLRNetworkManagementQuery_ProjectsLocationsGet *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRNetworkManagement_Location class];
  query.loggingName = @"networkmanagement.projects.locations.get";
  return query;
}

@end

@implementation GTLRNetworkManagementQuery_ProjectsLocationsGlobalConnectivityTestsCreate

@dynamic parent, testId;

+ (instancetype)queryWithObject:(GTLRNetworkManagement_ConnectivityTest *)object
                         parent:(NSString *)parent {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"parent" ];
  NSString *pathURITemplate = @"v1/{+parent}/connectivityTests";
  GTLRNetworkManagementQuery_ProjectsLocationsGlobalConnectivityTestsCreate *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.parent = parent;
  query.expectedObjectClass = [GTLRNetworkManagement_Operation class];
  query.loggingName = @"networkmanagement.projects.locations.global.connectivityTests.create";
  return query;
}

@end

@implementation GTLRNetworkManagementQuery_ProjectsLocationsGlobalConnectivityTestsDelete

@dynamic name;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v1/{+name}";
  GTLRNetworkManagementQuery_ProjectsLocationsGlobalConnectivityTestsDelete *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"DELETE"
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRNetworkManagement_Operation class];
  query.loggingName = @"networkmanagement.projects.locations.global.connectivityTests.delete";
  return query;
}

@end

@implementation GTLRNetworkManagementQuery_ProjectsLocationsGlobalConnectivityTestsGet

@dynamic name;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v1/{+name}";
  GTLRNetworkManagementQuery_ProjectsLocationsGlobalConnectivityTestsGet *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRNetworkManagement_ConnectivityTest class];
  query.loggingName = @"networkmanagement.projects.locations.global.connectivityTests.get";
  return query;
}

@end

@implementation GTLRNetworkManagementQuery_ProjectsLocationsGlobalConnectivityTestsGetIamPolicy

@dynamic optionsRequestedPolicyVersion, resource;

+ (NSDictionary<NSString *, NSString *> *)parameterNameMap {
  return @{ @"optionsRequestedPolicyVersion" : @"options.requestedPolicyVersion" };
}

+ (instancetype)queryWithResource:(NSString *)resource {
  NSArray *pathParams = @[ @"resource" ];
  NSString *pathURITemplate = @"v1/{+resource}:getIamPolicy";
  GTLRNetworkManagementQuery_ProjectsLocationsGlobalConnectivityTestsGetIamPolicy *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.resource = resource;
  query.expectedObjectClass = [GTLRNetworkManagement_Policy class];
  query.loggingName = @"networkmanagement.projects.locations.global.connectivityTests.getIamPolicy";
  return query;
}

@end

@implementation GTLRNetworkManagementQuery_ProjectsLocationsGlobalConnectivityTestsList

@dynamic filter, orderBy, pageSize, pageToken, parent;

+ (instancetype)queryWithParent:(NSString *)parent {
  NSArray *pathParams = @[ @"parent" ];
  NSString *pathURITemplate = @"v1/{+parent}/connectivityTests";
  GTLRNetworkManagementQuery_ProjectsLocationsGlobalConnectivityTestsList *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.parent = parent;
  query.expectedObjectClass = [GTLRNetworkManagement_ListConnectivityTestsResponse class];
  query.loggingName = @"networkmanagement.projects.locations.global.connectivityTests.list";
  return query;
}

@end

@implementation GTLRNetworkManagementQuery_ProjectsLocationsGlobalConnectivityTestsPatch

@dynamic name, updateMask;

+ (instancetype)queryWithObject:(GTLRNetworkManagement_ConnectivityTest *)object
                           name:(NSString *)name {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v1/{+name}";
  GTLRNetworkManagementQuery_ProjectsLocationsGlobalConnectivityTestsPatch *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"PATCH"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.name = name;
  query.expectedObjectClass = [GTLRNetworkManagement_Operation class];
  query.loggingName = @"networkmanagement.projects.locations.global.connectivityTests.patch";
  return query;
}

@end

@implementation GTLRNetworkManagementQuery_ProjectsLocationsGlobalConnectivityTestsRerun

@dynamic name;

+ (instancetype)queryWithObject:(GTLRNetworkManagement_RerunConnectivityTestRequest *)object
                           name:(NSString *)name {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v1/{+name}:rerun";
  GTLRNetworkManagementQuery_ProjectsLocationsGlobalConnectivityTestsRerun *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.name = name;
  query.expectedObjectClass = [GTLRNetworkManagement_Operation class];
  query.loggingName = @"networkmanagement.projects.locations.global.connectivityTests.rerun";
  return query;
}

@end

@implementation GTLRNetworkManagementQuery_ProjectsLocationsGlobalConnectivityTestsSetIamPolicy

@dynamic resource;

+ (instancetype)queryWithObject:(GTLRNetworkManagement_SetIamPolicyRequest *)object
                       resource:(NSString *)resource {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"resource" ];
  NSString *pathURITemplate = @"v1/{+resource}:setIamPolicy";
  GTLRNetworkManagementQuery_ProjectsLocationsGlobalConnectivityTestsSetIamPolicy *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.resource = resource;
  query.expectedObjectClass = [GTLRNetworkManagement_Policy class];
  query.loggingName = @"networkmanagement.projects.locations.global.connectivityTests.setIamPolicy";
  return query;
}

@end

@implementation GTLRNetworkManagementQuery_ProjectsLocationsGlobalConnectivityTestsTestIamPermissions

@dynamic resource;

+ (instancetype)queryWithObject:(GTLRNetworkManagement_TestIamPermissionsRequest *)object
                       resource:(NSString *)resource {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"resource" ];
  NSString *pathURITemplate = @"v1/{+resource}:testIamPermissions";
  GTLRNetworkManagementQuery_ProjectsLocationsGlobalConnectivityTestsTestIamPermissions *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.resource = resource;
  query.expectedObjectClass = [GTLRNetworkManagement_TestIamPermissionsResponse class];
  query.loggingName = @"networkmanagement.projects.locations.global.connectivityTests.testIamPermissions";
  return query;
}

@end

@implementation GTLRNetworkManagementQuery_ProjectsLocationsGlobalOperationsCancel

@dynamic name;

+ (instancetype)queryWithObject:(GTLRNetworkManagement_CancelOperationRequest *)object
                           name:(NSString *)name {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v1/{+name}:cancel";
  GTLRNetworkManagementQuery_ProjectsLocationsGlobalOperationsCancel *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.name = name;
  query.expectedObjectClass = [GTLRNetworkManagement_Empty class];
  query.loggingName = @"networkmanagement.projects.locations.global.operations.cancel";
  return query;
}

@end

@implementation GTLRNetworkManagementQuery_ProjectsLocationsGlobalOperationsDelete

@dynamic name;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v1/{+name}";
  GTLRNetworkManagementQuery_ProjectsLocationsGlobalOperationsDelete *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"DELETE"
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRNetworkManagement_Empty class];
  query.loggingName = @"networkmanagement.projects.locations.global.operations.delete";
  return query;
}

@end

@implementation GTLRNetworkManagementQuery_ProjectsLocationsGlobalOperationsGet

@dynamic name;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v1/{+name}";
  GTLRNetworkManagementQuery_ProjectsLocationsGlobalOperationsGet *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRNetworkManagement_Operation class];
  query.loggingName = @"networkmanagement.projects.locations.global.operations.get";
  return query;
}

@end

@implementation GTLRNetworkManagementQuery_ProjectsLocationsGlobalOperationsList

@dynamic filter, name, pageSize, pageToken;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v1/{+name}/operations";
  GTLRNetworkManagementQuery_ProjectsLocationsGlobalOperationsList *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRNetworkManagement_ListOperationsResponse class];
  query.loggingName = @"networkmanagement.projects.locations.global.operations.list";
  return query;
}

@end

@implementation GTLRNetworkManagementQuery_ProjectsLocationsList

@dynamic filter, name, pageSize, pageToken;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v1/{+name}/locations";
  GTLRNetworkManagementQuery_ProjectsLocationsList *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRNetworkManagement_ListLocationsResponse class];
  query.loggingName = @"networkmanagement.projects.locations.list";
  return query;
}

@end
