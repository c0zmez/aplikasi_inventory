import 'package:aplikasi_inventory/constants/color.dart';
import 'package:aplikasi_inventory/models/product_model.dart';
import 'package:aplikasi_inventory/services/api_service.dart';
import 'package:aplikasi_inventory/ui/shared/ui_helper.dart';
import 'package:aplikasi_inventory/ui/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class InventoryListView extends StatefulWidget {
  const InventoryListView({Key? key}) : super(key: key);

  @override
  _InventoryListViewState createState() => _InventoryListViewState();
}

class _InventoryListViewState extends State<InventoryListView> {

  bool isApiCallProcess = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite2,
      body: SingleChildScrollView(
        child: Column(
          children: [
            verticalSpaceLarge,
            const Text(
              'List Barang',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25
              ),
            ),
            ProgressHUD(
              child: loadProducts(),
              inAsyncCall: isApiCallProcess,
              opacity: 0.3,
              key: UniqueKey(),
            ),
          ],
        ),
      ),
    );
  }

  Widget loadProducts() {
    return FutureBuilder(
      future: APIService.getProducts(),
      builder: (
          BuildContext context,
          AsyncSnapshot<List<ProductModel>?> model,
          ) {
        if (model.hasData) {
          return productList(model.data);
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget productList(products) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductItem(
                    model: products[index],
                    onDelete: (ProductModel model) {
                      setState(() {
                        isApiCallProcess = true;
                      });
                      APIService.deleteProduct(model.id).then(
                            (response) {
                          setState(() {
                            isApiCallProcess = false;
                          });
                        },
                      );
                    },
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
