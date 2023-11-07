import 'package:craftybay/data/models/payment_method.dart';
import 'package:craftybay/presentation/state_holders/create_invoice_controller.dart';
import 'package:craftybay/presentation/ui/screens/webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<CreateInvoiceController>().createInvoice().then((value) {
        isCompleted = value;
        if(mounted) {
          setState(() {});
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check Out'),
      ),
      body: GetBuilder<CreateInvoiceController>(
          builder: (controller) {
            if(controller.inProgress){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if(!isCompleted){
              return const Center(
                child: Text('Please Complete Your Profile'),
              );
            }
        return ListView.separated(
          itemCount:
              controller.invoiceCreateResponseModel?.paymentMethod?.length ?? 0,
          itemBuilder: (context, index) {
            final PaymentMethod paymentMethod =
                controller.invoiceCreateResponseModel!.paymentMethod![index];
            return ListTile(
              leading: Image.network(paymentMethod.logo ?? '',width: 60),
              title: Text(paymentMethod.name ?? ''),
              onTap: () {
                Get.off(() => WebviewScreen(paymentUrl: paymentMethod.redirectGatewayURL!));
              },
            );
          }, separatorBuilder: (BuildContext context, int index) {
            return const Divider();
        },
        );
      }),
    );
  }
}
