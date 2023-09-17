import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic7_multistore/utils/price_ext.dart';
//import 'package:multistore_app/pages/base_widgets/payment/payment_page.dart';

import '../../bloc/checkout/checkout_bloc.dart';
import '../../utils/color_resources.dart';
import '../../utils/custom_themes.dart';
import '../../utils/dimensions.dart';
import '../../utils/images.dart';
import '../base_widgets/amount_widget.dart';
//import '../base_widgets/amount_widget.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final TextEditingController _shoppingAddress = TextEditingController();
  int subTotal = 0;
  int totalPrice = 0;
  int shippingCost = 22000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: BlocBuilder<CheckoutBloc, CheckoutState>(builder: (context, state) {
        return state.maybeWhen(orElse: () {
          return CircularProgressIndicator();
        }, loaded: (products) {
          products.forEach((element) {
            subTotal += element.quantity * element.product.price!;
          });
          totalPrice = subTotal + shippingCost;
          return ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeDefault),
                child: Text(
                  'Shipping Address',
                  style:
                      robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  child: TextField(
                    controller: _shoppingAddress,
                    maxLines: 4,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1))),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeDefault),
                child: Text(
                  'Order Detail',
                  style:
                      robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
                ),
              ),
              Container(
                  // transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: products.length,
                      itemBuilder: (ctx, index) {
                        final productQuantity = products[index];
                        return Padding(
                          padding: const EdgeInsets.all(
                              Dimensions.paddingSizeDefault),
                          child: Row(children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: .5,
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(.25)),
                                borderRadius: BorderRadius.circular(
                                    Dimensions.paddingSizeExtraExtraSmall),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.paddingSizeExtraExtraSmall),
                                child: FadeInImage.assetNetwork(
                                  placeholder: Images.placeholder,
                                  fit: BoxFit.cover,
                                  width: 50,
                                  height: 50,
                                  image: productQuantity.product.imageProduct!,
                                  imageErrorBuilder: (c, o, s) => Image.asset(
                                      Images.placeholder,
                                      fit: BoxFit.cover,
                                      width: 50,
                                      height: 50),
                                ),
                              ),
                            ),
                            const SizedBox(width: Dimensions.marginSizeDefault),
                            Expanded(
                              flex: 3,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            productQuantity.product.name!,
                                            style: titilliumRegular.copyWith(
                                                fontSize:
                                                    Dimensions.fontSizeDefault,
                                                color:
                                                    ColorResources.getPrimary(
                                                        context)),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: Dimensions.paddingSizeSmall,
                                        ),
                                        Text(
                                          '${productQuantity.product.price! * productQuantity.quantity}'
                                              .formatPrice(),
                                          style: titilliumSemiBold.copyWith(
                                              fontSize:
                                                  Dimensions.fontSizeLarge),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                        height:
                                            Dimensions.marginSizeExtraSmall),
                                    Row(children: [
                                      Text('Qty -  ${productQuantity.quantity}',
                                          style: titilliumRegular.copyWith()),
                                    ]),
                                  ]),
                            ),
                          ]),
                        );
                      })),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(.055),
                ),
                child: Center(
                    child: Text(
                  'Order Summary',
                  style: titilliumSemiBold.copyWith(
                      fontSize: Dimensions.fontSizeLarge),
                )),
              ),
              // Total bill
              Container(
                  margin:
                      const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  color: Theme.of(context).highlightColor,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AmountWidget(
                            title: 'Sub Total :',
                            amount: '${subTotal}'.formatPrice()),
                        AmountWidget(
                            title: 'Shipping Cost: ',
                            amount: '${shippingCost}'.formatPrice()),
                        Divider(height: 5, color: Theme.of(context).hintColor),
                        AmountWidget(
                            title: 'Total :',
                            amount: '${totalPrice}'.formatPrice()),
                      ])),
            ],
          );
        });
      }),
      bottomNavigationBar: InkWell(
        onTap: () {
          /*  Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const PaymentPage(
                url:
                    'https://app.sandbox.midtrans.com/snap/v3/redirection/ab82a184-d0dd-4f6f-b9b3-977e0223f801');
          })); */
        },
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeLarge,
              vertical: Dimensions.paddingSizeDefault),
          decoration: BoxDecoration(
            color: ColorResources.getPrimary(context),
          ),
          child: Center(
              child: Builder(
            builder: (context) => Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 2.9),
              child: Text('Proceed',
                  style: titilliumSemiBold.copyWith(
                    fontSize: Dimensions.fontSizeExtraLarge,
                    color: Theme.of(context).cardColor,
                  )),
            ),
          )),
        ),
      ),
    );
  }
}

class PaymentButton extends StatelessWidget {
  final String image;
  final Function? onTap;
  const PaymentButton({Key? key, required this.image, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Container(
        height: 45,
        margin: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeExtraSmall),
        padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: ColorResources.getGrey(context)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.asset(image),
      ),
    );
  }
}

class PaymentMethod {
  String name;
  String image;
  PaymentMethod(this.name, this.image);
}
