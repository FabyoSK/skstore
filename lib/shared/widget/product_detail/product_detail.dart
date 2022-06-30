import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:store/shared/models/product_model.dart';

class ProductDetail extends StatelessWidget {
  final ProductModel product;

  const ProductDetail({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // onTap(product.id);
      },
      child: Card(
        elevation: 4.0,
        child: Container(
          width: 300,
          height: 300,
          child: Column(
            children: [
              ListTile(
                title: Text(product.name),
                subtitle: Text(product.description),
                trailing: Icon(Icons.favorite_outline),
              ),
              Container(
                // height: 200.0,
                // width: 200.0,
                child: Image.network(
                  'https://placeimg.com/640/480/any',
                  fit: BoxFit.fill,
                ),
              ),
              // Container(
              //   padding: EdgeInsets.all(16.0),
              //   alignment: Alignment.centerLeft,
              //   child: Text(product.description),
              // ),
              // ButtonBar(
              //   children: [
              //     TextButton(
              //       child: const Text('CONTACT AGENT'),
              //       onPressed: () {/* ... */},
              //     ),
              //     TextButton(
              //       child: const Text('LEARN MORE'),
              //       onPressed: () {/* ... */},
              //     )
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
