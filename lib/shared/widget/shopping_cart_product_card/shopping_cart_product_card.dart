import 'package:flutter/material.dart';
import 'package:store/shared/models/product_model.dart';

class ShoppingCartProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onTap;
  final VoidCallback onCartButtonTap;

  const ShoppingCartProductCard(
      {Key? key,
      required this.product,
      required this.onTap,
      required this.onCartButtonTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4.0,
        child: Container(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Image.network(
                  product.image,
                  fit: BoxFit.cover,
                ),
                height: 150,
                width: 300,
              ),
              SizedBox(
                height: 8.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      product.name,
                      style: TextStyle(fontSize: 16.0, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "\$${product.price}",
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        // Text(
                        //   "$discount\% off",
                        //   style: TextStyle(fontSize: 12.0, color: Colors.grey),
                        // ),
                      ],
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                  ],
                ),
              ),
              ButtonBar(
                children: [
                  ElevatedButton(
                    onPressed: onCartButtonTap,
                    child: Icon(Icons.shopping_cart),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
