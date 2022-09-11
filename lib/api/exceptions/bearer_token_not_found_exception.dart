class BearerTokenNotFoundException implements Exception {
  final String tokenKey;

  const BearerTokenNotFoundException(this.tokenKey);

  @override
  String toString() {
    return 'Bearer token with key $tokenKey not found';
  }
}
