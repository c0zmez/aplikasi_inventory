import 'dart:io';

import 'package:aplikasi_inventory/constants/color.dart';
import 'package:aplikasi_inventory/models/product_model.dart';
import 'package:aplikasi_inventory/services/api_service.dart';
import 'package:aplikasi_inventory/ui/shared/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../../../config.dart';
import '../navbar.dart';


class AddEditItem extends StatefulWidget {
  const AddEditItem({Key? key}) : super(key: key);

  @override
  _AddEditItemState createState() => _AddEditItemState();
}

class _AddEditItemState extends State<AddEditItem> {
  ProductModel? productModel;
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;
  List<Object> images = [];
  bool isEditMode = false;
  bool isImageSelected = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colorWhite2,
        body: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: productForm(),
          ),
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    productModel = ProductModel();
    Future.delayed(Duration.zero, () {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
        productModel = arguments['model'];
        isEditMode = true;
        setState(() {});
      }
    });
  }

  Widget productForm() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          verticalSpaceMedium,
          Container(
            width: MediaQuery.of(context).size.width*0.85,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25))
            ),
            margin: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              "ProductName",
              "Nama Produk",
                  (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Nama produk tidak bisa kosong.';
                }

                return null;
              },
                  (onSavedVal) => {
                productModel!.productName = onSavedVal,
              },
              paddingRight: 0,
              paddingLeft: 0,
              initialValue: productModel!.productName ?? "",
              obscureText: false,
              borderFocusColor: colorGreen,
              borderColor: colorGreen,
              textColor: Colors.black,
              hintColor: colorGrey,
              borderRadius: 15,
              showPrefixIcon: false,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width*0.85,
            decoration: const BoxDecoration(

                borderRadius: BorderRadius.all(Radius.circular(25))
            ),
            margin: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              "ProductType",
              "Tipe Produk",
                  (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Tipe produk tidak bisa kosong.';
                }
                return null;
              },
                  (onSavedVal) => {
                productModel!.productType = onSavedVal,
              },
              paddingRight: 0,
              paddingLeft: 0,
              initialValue: productModel!.productType ?? "",
              obscureText: false,
              borderFocusColor: colorGreen,
              borderColor: colorGreen,
              textColor: Colors.black,
              hintColor: colorGrey,
              borderRadius: 15,
              showPrefixIcon: false,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width*0.85,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25))
            ),
            margin: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              "ProductPrice",
              "Jumlah Produk",
                  (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Jumlah produk tidak boleh kosong.';
                }
                return null;
              },
                  (onSavedVal) => {
                productModel!.productAmount = int.parse(onSavedVal),
              },
              initialValue: productModel!.productAmount == null
                  ? ""
                  : productModel!.productAmount.toString(),
              paddingRight: 0,
              paddingLeft: 0,
              obscureText: false,
              borderFocusColor: colorGreen,
              borderColor: colorGreen,
              textColor: Colors.black,
              hintColor: colorGrey,
              borderRadius: 15,
              showPrefixIcon: false,
            ),
          ),
          verticalSpaceMedium,
          picPicker(
            isImageSelected,
            productModel!.productImage ?? "",
                (file) => {
              setState(
                    () {
                  productModel!.productImage = file.path;
                  isImageSelected = true;
                },
              )
            },
          ),
          verticalSpaceMedium,
          Center(
            child: FormHelper.submitButton(
              "Save",
                  () {
                if (validateAndSave()) {
                  print(productModel!.toJson());

                  setState(() {
                    isApiCallProcess = true;
                  });

                  APIService.saveProduct(
                    productModel!,
                    isEditMode,
                    isImageSelected,
                  ).then(
                        (response) {
                      setState(() {
                        isApiCallProcess = false;
                      });

                      if (response) {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Navbar()));
                      } else {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          Config.appName,
                          "Error occur",
                          "OK",
                              () {
                            Navigator.of(context).pop();
                          },
                        );
                      }
                    },
                  );
                }
              },
              btnColor: colorGreen,
              borderColor: colorGreen,
              txtColor: Colors.white,
              borderRadius: 25,
            ),
          ),
          verticalSpaceMedium,
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  static Widget picPicker(
      bool isImageSelected,
      String fileName,
      Function onFilePicked,
      ) {
    Future<XFile?> _imageFile;
    ImagePicker _picker = ImagePicker();

    return Column(
      children: [
        fileName.isNotEmpty
            ? isImageSelected
            ? Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              border: Border.all(
                  color: colorGreen,
                  width: 4
              )
          ),
          child: Image.file(
            File(fileName),
            width: 300,
            height: 300,
          ),
        )
            : Container(
          decoration: BoxDecoration(
          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                border: Border.all(
                    color: colorGreen,
                    width: 4
                )
            ),
            child: Image.network(
              fileName,
              width: 200,
              height: 200,
              fit: BoxFit.scaleDown,
            ),
          ),
        )
            : Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                border: Border.all(
                    color: colorGreen,
                    width: 4
                )
            ),
            child: Icon(Icons.image_outlined, size: 70, color: colorGrey,)
        ),
        verticalSpaceMedium,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                border: Border.all(color: colorGreen, width: 3),
              ),
              height: 50.0,
              width: 50.0,
              child: IconButton(
                padding: const EdgeInsets.all(0),
                icon: const Icon(Icons.image, size: 25.0, color: colorGrey),
                onPressed: () {
                  _imageFile = _picker.pickImage(source: ImageSource.gallery);
                  _imageFile.then((file) async {
                    onFilePicked(file);
                  });
                },
              ),
            ),
            horizontalSpaceMedium,
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                border: Border.all(color: colorGreen, width: 3),
              ),
              height: 50.0,
              width: 50.0,
              child: IconButton(
                icon: const Icon(Icons.add_a_photo, size: 25.0,  color: colorGrey),
                onPressed: () {
                  _imageFile = _picker.pickImage(source: ImageSource.camera);
                  _imageFile.then((file) async {
                    onFilePicked(file);
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  isValidURL(url) {
    return Uri.tryParse(url)?.hasAbsolutePath ?? false;
  }
}
