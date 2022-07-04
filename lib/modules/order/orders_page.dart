import 'package:flutter/material.dart';
import 'package:store/modules/order/order_controller.dart';
import 'package:store/shared/models/order_model.dart';
import 'package:store/shared/utils/format_currency.dart';
import 'package:store/shared/themes/app_text_styles.dart';
import 'package:store/shared/widget/page_wrapper/page_wrapper.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  String totalSum = "0";
  Order? currentOrder;
  OrderController controller = OrderController();

  ValueNotifier<Order?> currentOrderNotifier = ValueNotifier(null);

  String calculateTotal(List<Product> products) {
    double sum = 0;
    for (Product product in products) {
      final price = double.parse(product.price);
      final quantity = double.parse(product.quantity);
      final totalPrice = price * quantity;
      sum += totalPrice;
    }

    return FormatCurrency.format(sum);
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "My Orders",
            style: TextStyles.title,
          ),
        ],
      ),
    );
  }

  Widget _buildOrderInfo() {
    return Expanded(
      flex: 2,
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: ValueListenableBuilder(
            valueListenable: currentOrderNotifier,
            builder: (BuildContext context, Order? currentOrder, _) {
              return currentOrder == null
                  ? const Center(
                      child: Text(
                          "Please select an order to view more information."),
                    )
                  : Column(
                      children: [
                        Text(
                          "Products",
                          style: TextStyles.textBold,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: currentOrder.products.length,
                          itemBuilder: (BuildContext context, int index) {
                            Product product = currentOrder.products[index];
                            double total = double.parse(product.price) *
                                double.parse(product.quantity);

                            String formattedPrice = FormatCurrency.format(
                                double.parse(product.price));
                            String formattedTotal =
                                FormatCurrency.format(total);

                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: Image.network(
                                          product.imageUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.name,
                                            style: TextStyles.text,
                                          ),
                                          Text("Quantity: ${product.quantity}"),
                                          Text("Price: $formattedPrice"),
                                          Text("Total: $formattedTotal")
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        Text(
                          "Total: ${calculateTotal(currentOrder.products)}",
                          style: TextStyles.bigTextBold,
                        )
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildList(List<Order> orders) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: orders.length,
      itemBuilder: (BuildContext context, int index) {
        Order order = orders[index];
        String total = calculateTotal(order.products);
        return InkWell(
          onTap: () {
            currentOrderNotifier.value = order;
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Order: ${order.id}",
                      style: TextStyles.text,
                    ),
                    Text("Total: $total")
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(),
                  FutureBuilder<List<Order>>(
                    future: controller.getOrders(),
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<List<Order>> snapshot,
                    ) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasError) {
                          // implement screen for when the user doesn't have any order
                          return Text(snapshot.error.toString());
                        } else if (snapshot.hasData) {
                          return _buildList(snapshot.data!);
                        } else {
                          return const Text('Empty data');
                        }
                      } else {
                        return Text('State: ${snapshot.connectionState}');
                      }
                    },
                  )
                ],
              ),
            ),
          ),
          _buildOrderInfo(),
        ],
      ),
    );
  }
}
