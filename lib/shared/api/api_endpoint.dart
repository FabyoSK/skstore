class ApiEndpoint {
  static final api_url = 'http://localhost:3333';
  static final create_user = '/users';
  static final create_session = '/sessions';

  static final get_products = '/products/';
  static final get_orders = '/orders';

  static final checkout = '/checkout';

  static String resolve_endpoint(String path) {
    return api_url + path;
  }
}
