import 'package:aplikasi_inventory/constants/color.dart';
import 'package:aplikasi_inventory/models/product_model.dart';
import 'package:aplikasi_inventory/ui/shared/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class ProductItem extends StatelessWidget {
  final ProductModel? model;
  final Function? onDelete;

  ProductItem({
    Key? key,
    this.model,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Container(
        height: 165,
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: BoxDecoration(
          color: colorLightGreen,
          borderRadius: BorderRadius.circular(25),
        ),
        child: cartItem(context),
      ),
    );
  }

  Widget cartItem(context) {
    return Stack(
      children: [
        Row(
          children: <Widget>[
            verticalSpaceMedium,
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(top: 5, left: 30),
                height: 115,
                width: 115,
                child: Image.network(
                  (model!.productImage == null || model!.productImage == "")
                      ? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png"
                      : model!.productImage!,
                ),
              ),
            ),
            horizontalSpaceMedium,
            Container(
              height: 125,
              width: MediaQuery.of(context).size.width * 0.375,
              child: Column(
                children: [
                  verticalSpaceMedium,
                  Container(
                    width: MediaQuery.of(context).size.width * 0.375,
                    child: Text(
                      model!.productName!,
                      style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  verticalSpaceSmall,
                  Container(
                    width: MediaQuery.of(context).size.width * 0.375,
                    child: Text(
                      'Tipe : ${model!.productType}',
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ),
                  verticalSpaceVeryTiny,
                  Container(
                    width: MediaQuery.of(context).size.width * 0.375,
                    child: Text(
                      'Jumlah : ${model!.productAmount}',
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.only(top: 5,right: 5),
          alignment: Alignment.topRight,
          child: Column(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    '/edit-product',
                    arguments: {
                      'model': model,
                    },
                  );
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  onDelete!(model);
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
