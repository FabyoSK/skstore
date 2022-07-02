class ApiEndpoint {
  static const api_url = 'http://localhost:3333';
  static const create_user = '/users';
  static const create_session = '/sessions';

  static const get_products = '/products/';
  static const get_orders = '/orders';

  static const checkout = '/checkout';

  static String resolve_endpoint(String path) {
    return api_url + path;
  }
}
