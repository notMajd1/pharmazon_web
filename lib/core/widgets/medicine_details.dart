import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmazon_web/constants.dart';
import 'package:pharmazon_web/core/utils/functions/custom_snack_bar.dart';
import 'package:pharmazon_web/features/order/data/models/order/pharmaceutical.details.dart';
import 'package:pharmazon_web/features/home/presentation/manager/edit_quantity_cubit/edit_quantity_cubit.dart';
import 'package:pharmazon_web/features/home/presentation/views/widgets/AddTextField.dart';
import 'package:pharmazon_web/generated/l10n.dart';

final controller = TextEditingController();

class MedicineDetails extends StatelessWidget {
  const MedicineDetails({super.key, required this.medicineModel});
  final Pharmaceutical medicineModel;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${S.of(context).medicineDetailsfor} ${medicineModel.commercialName}'),
      ),
      body: BlocListener<EditQuantityCubit, EditQuantityState>(
        listener: (context, state) {
          
          if (state is EditQuantitySuccess) {
            controller.clear();
            customSnackBar(context, state.editedMedicine['message']);

          }
          if (state is EditQuantityFailure) {
            controller.clear();
            customSnackBar(context, state.errMessage=='Your request not found, Please try later!'?S.of(context).cantEdit:'Your request not found, Please try later!');

          }

        },
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            height: screenHeight * 0.7,
            width: screenWidth * 0.5,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(20, 20),
                  blurRadius: 10,
                  color: kAppColor,
                )
              ],
            ),
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildDetailItem(S.of(context).scientificName,
                    medicineModel.scientificName!),
                _buildDetailItem(S.of(context).commercialName,
                    medicineModel.commercialName!),
                _buildDetailItem(S.of(context).manufactureCompany,
                    medicineModel.manufactureCompany!),
                _buildDetailItem(S.of(context).quantityAvailable,
                    medicineModel.quantityAvailable.toString()),
                _buildDetailItem(
                    S.of(context).expireDate, medicineModel.expireDate!),
                _buildDetailItem(
                    S.of(context).price, medicineModel.price.toString()),
                _buildDetailItem(S.of(context).calssification,
                    medicineModel.calssification!),
                SizedBox(height: screenHeight * 0.05),
                AddTextField(
                  textInputType: TextInputType.number,
                  controller: controller,
                  onTap: () {
                    if (controller.text.isEmpty) {
                      return;
                    }
                    BlocProvider.of<EditQuantityCubit>(context).editQuantity(
                      id: medicineModel.id.toString(),
                      quantity: controller.text,
                    );
                  //  controller.clear();
                 //   customSnackBar(
                    //    context, S.of(context).quantityUpdatedSuccessfully);
                  },
                  hintext: S.of(context).editTheQuantity,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 18, color: Colors.black),
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
