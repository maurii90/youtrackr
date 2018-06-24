const String FETCH_SERVICE_INFORMATION_URL = '/api/config?fields=ring(url,serviceId),mobile(serviceSecret,serviceId)';
const String REQUEST_AUTH_TOKEN_URL = '/api/rest/oauth2/token';
const String FETCH_TODAY_UPDATED_ISSUES_URL = '/rest/issue?filter=updated+by%3A{username}+updated%3A+today';
const String FETCH_ISSUE_TIME_TRACKING_WORK_ITEMS_URL = '/rest/issue/{issue}/timetracking/workitem/';
const String FETCH_USER_DATA_URL = '/api/rest/users/me?fields=id,name,profile/avatar/url';