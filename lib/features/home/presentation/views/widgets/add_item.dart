import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmazon_web/core/utils/functions/custom_snack_bar.dart';
import 'package:pharmazon_web/core/widgets/custom_button.dart';
import 'package:pharmazon_web/core/widgets/custom_loading.dart';
import 'package:pharmazon_web/features/home/presentation/manager/add_item_cubit/add_item_cubit.dart';
import 'package:pharmazon_web/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:pharmazon_web/generated/l10n.dart';

late String scientificName;
late String commerialName;
late String calssification;
late String manufactureCompany;
late int quantityAvailable;
late String expireDate;
late int price;

TextEditingController controller = TextEditingController();

class AddItem extends StatefulWidget {
  const AddItem({
    super.key,
  });

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocConsumer<AddItemCubit, AddItemState>(
        listener: (context, state) {
          if (state is AddItemFailure) {
            customSnackBar(context, state.errMessage);
          }
          if (state is AddItemSuccess) {
            customSnackBar(context, S.of(context).addedSuccessfully);
          }
        },
        builder: (context, state) {
          if (state is AddItemLoading) {
            return const CustomLoading();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    ..._buildTextFormFields(context),
                    const SizedBox(height: 20),
                    CustomButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          BlocProvider.of<AddItemCubit>(context).addMedicine(
                            scientificName: scientificName,
                            commerialName: commerialName,
                            calssification: calssification,
                            manufactureCompany: manufactureCompany,
                            quantityAvailable: quantityAvailable,
                            expireDate: expireDate,
                            price: price,
                          );
                          controller.clear();
                        }
                      },
                      text: S.of(context).add,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildTextFormFields(BuildContext context) {
    return [
      _buildTextFormField(
          S.of(context).scientificName, (value) => scientificName = value),
      const SizedBox(height: 10),
      _buildTextFormField(
          S.of(context).commercialName, (value) => commerialName = value),
      const SizedBox(height: 10),
      _buildTextFormField(
          S.of(context).calssification, (value) => calssification = value),
      const SizedBox(height: 10),
      _buildTextFormField(S.of(context).manufactureCompany,
          (value) => manufactureCompany = value),
      const SizedBox(height: 10),
      _buildTextFormField(S.of(context).quantityAvailable,
          (value) => quantityAvailable = int.parse(value)),
      const SizedBox(height: 10),
      _buildDatePicker(context),
      const SizedBox(height: 10),
      _buildTextFormField(
          S.of(context).price, (value) => price = int.parse(value)),
    ];
  }

  TextFormField _buildTextFormField(String label, Function(String) onSaved) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return S.of(context).pleaseEnterSomeText;
        }
        return null;
      },
      onSaved: (newValue) => onSaved(newValue!),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: S.of(context).expireDate,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return S.of(context).pleaseEnterSomeText;
        }
        return null;
      },
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2023, 10),
          lastDate: DateTime(2035),
        );
        if (picked != null) {
          expireDate = picked.toString().split(' ')[0];
          setState(() {
            controller.text = expireDate;
          });
        }
      },
    );
  }
}
