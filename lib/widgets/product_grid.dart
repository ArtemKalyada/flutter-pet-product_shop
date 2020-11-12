import 'package:flutter/cupertino.dart';
import 'package:product_shop/providers/products/products.dart';
import 'package:product_shop/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavorite;

  ProductsGrid(this.showFavorite);

  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);
    final loadedProducts = showFavorite
        ? productData.loadedProducts
            .where((element) => element.isFavourite)
            .toList()
        : productData.loadedProducts;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 3 / 2),
      itemCount: loadedProducts.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: loadedProducts[i],
        child: ProductItem(
//          id: loadedProducts[i].id,
//          title: loadedProducts[i].title,
//          imageUrl: loadedProducts[i].imageUrl,
            ),
      ),
      padding: const EdgeInsets.all(10),
    );
  }
}
