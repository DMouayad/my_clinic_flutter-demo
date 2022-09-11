class ApiEndpoint {
  final String url;
  final bool requiresToken;

  const ApiEndpoint(this.url, {this.requiresToken = false});
}

class ApiEndpoints {
  static const register = ApiEndpoint('/register');
  static const login = ApiEndpoint('/login');
  static const logout = ApiEndpoint('/logout', requiresToken: true);
}
