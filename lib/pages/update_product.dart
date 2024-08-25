import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:store/helper/show_snack_bar.dart';
import 'package:store/models/product_model.dart';
import 'package:store/services/update_product.dart';
import 'package:store/widgets/custom_button.dart';
import 'package:store/widgets/custom_text_field.dart';

// ignore: must_be_immutable
class UpdateProduct extends StatefulWidget {
  UpdateProduct({super.key});
  static String id = 'UpdateProduct';

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  String? productName, desc, image;

  String? price;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    ProductModel productModel =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          // automaticallyImplyLeading: false,
          title: const Text(
            'Update Product',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 150,
                ),
                CustomTextField(
                    onChanged: (data) {
                      productName = data;
                    },
                    hintText: 'Product Name'),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                    onChanged: (data) {
                      desc = data;
                    },
                    hintText: 'Description'),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                    inputType: TextInputType.number,
                    onChanged: (data) {
                      price = data;
                    },
                    hintText: 'Price'),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                    onChanged: (data) {
                      image = data;
                    },
                    hintText: 'Image'),
                const SizedBox(
                  height: 50,
                ),
                CustomButton(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await updateProduct(productModel);
                      try {
                        showSnackBar(context, 'Success');
                      } catch (e) {
                        showSnackBar(context, e.toString());
                      }

                      setState(() {
                        isLoading = false;
                      });
                    },
                    text: 'Update'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateProduct(ProductModel productModel) async {
    await UpdateProductService().updateProduct(
        title: productName == null ? productModel.title : productName!,
        price: price == null ? productModel.price.toString() : price!,
        description: desc == null ? productModel.description : desc!,
        image: image == null ? productModel.image : image!,
        category: productModel.category,
        id: productModel.id);
  }
}
