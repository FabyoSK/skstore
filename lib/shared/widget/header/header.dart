import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/restart_widget.dart';
import 'package:store/shared/models/cart_model.dart';
import 'package:store/shared/models/user_model.dart';
import 'package:store/shared/themes/app_text_styles.dart';

class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  final searchInputController = TextEditingController();

  void restoreLastQuery() async {
    final instance = await SharedPreferences.getInstance();
    searchInputController.text = instance.getString("lastQuery") ?? "";
  }

  @override
  void initState() {
    super.initState();
    restoreLastQuery();
  }

  void goToHomePage(BuildContext context) {
    Navigator.pushNamed(context, "/home");
  }

  void goToShoppingCartPage(BuildContext context) {
    Navigator.pushNamed(context, "/shoppingcart");
  }

  void goToMyOrdersPage(BuildContext context) {
    Navigator.pushNamed(context, "/orders");
  }

  void goToLoginPage(BuildContext context) {
    Navigator.pushNamed(context, "/login");
  }

  void goToSearchPage(BuildContext context, String query) {
    Navigator.pushNamed(context, "/search", arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();
    var user = context.watch<UserModel?>();
    int cartProductCount = cart.getProducts().length;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: () => goToHomePage(context),
              child: Text(
                "SKStore",
                style: TextStyles.bigTextBold,
              )),
          SizedBox(
            width: 400,
            child: TextField(
              controller: searchInputController,
              decoration: const InputDecoration(
                hintText: 'Search for...',
                labelText: "Search for...",
                suffixIcon: Icon(Icons.search),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: OutlineInputBorder(
                    // borderRadius: BorderRadius.circular(8),
                    ),
              ),
              onSubmitted: (value) async {
                if (value.isNotEmpty) {
                  goToSearchPage(context, value);
                  final instance = await SharedPreferences.getInstance();
                  instance.setString("lastQuery", value);
                }
              },
            ),
          ),
          Row(
            children: [
              Badge(
                badgeContent: Text(cartProductCount.toString()),
                child: InkWell(
                    onTap: () => goToShoppingCartPage(context),
                    child: const Icon(Icons.shopping_cart_checkout)),
              ),
              const SizedBox(
                width: 16,
              ),
              if (user != null)
                PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: InkWell(
                        onTap: () => goToMyOrdersPage(context),
                        child: Row(
                          children: const [
                            Icon(Icons.shopping_bag_outlined),
                            SizedBox(
                              width: 10,
                            ),
                            Text("My Orders")
                          ],
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: InkWell(
                        onTap: () {
                          user?.clear();
                          user = null;
                          RestartWidget.restartApp(context);
                          goToHomePage(context);
                        },
                        child: Row(
                          children: const [
                            Icon(Icons.logout),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Logout")
                          ],
                        ),
                      ),
                    ),
                  ],
                  offset: const Offset(0, 30),
                  elevation: 2,
                  child: Row(
                    children: [
                      const Icon(Icons.account_circle),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(user!.email)
                    ],
                  ),
                )
              else
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        goToLoginPage(context);
                      },
                      child: const Text('Login'),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
