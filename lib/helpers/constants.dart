const AUTH0_DOMAIN = String.fromEnvironment('AUTH0_DOMAIN');
const AUTH0_CLIENT_ID = String.fromEnvironment('AUTH0_CLIENT_ID');
const AUTH0_ISSUER = 'https://$AUTH0_DOMAIN';
const BUNDLE_IDENTIFIER = 'machine.io.hubapp';
const AUTH0_REDIRECT_URI = '$BUNDLE_IDENTIFIER://login-callback';
const REFRESH_TOKEN_KEY = 'refresh_token';
const HUB_API_AUDIENCE = 'https://hub-controller';
const HUB_API_DOMAIN = '65052d7tk3.execute-api.ap-southeast-2.amazonaws.com';
