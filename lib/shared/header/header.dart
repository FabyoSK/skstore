import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/shared/models/cart_model.dart';

class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  String searchQuery = "";

  void goToHomePage(BuildContext context) {
    Navigator.pushNamed(context, "/home");
  }

  void goToShoppingCartPage(BuildContext context) {
    Navigator.pushNamed(context, "/shoppingcart");
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();
    var cartProductCount = cart.getProducts().length;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(onTap: () => goToHomePage(context), child: Text("SK Shop")),
          SizedBox(
            width: 400,
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Search for...',
                labelText: "Search for...",
                border: OutlineInputBorder(
                    // borderRadius: BorderRadius.circular(8),
                    ),
              ),
              onChanged: (value) {
                setState(
                  () {
                    searchQuery = value;
                  },
                );
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
                width: 12,
              ),
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
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
                  PopupMenuItem(
                    value: 2,
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
                ],
                offset: const Offset(0, 30),
                elevation: 2,
                child: const Icon(Icons.account_circle),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
