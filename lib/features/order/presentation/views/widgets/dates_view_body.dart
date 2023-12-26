import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmazon_web/core/utils/app_router.dart';
import 'package:pharmazon_web/core/widgets/auth_button.dart';
import 'package:pharmazon_web/core/widgets/custom_error.dart';
import 'package:pharmazon_web/core/widgets/custom_loading.dart';
import 'package:pharmazon_web/features/order/presentation/manager/dates_cubit/dates_cubit.dart';
import 'package:pharmazon_web/generated/l10n.dart';

import 'date_list_view_item.dart';

class DatesViewBody extends StatelessWidget {
  const DatesViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<DatesCubit, DatesState>(
          builder: (context, state) {
            if (state is DatesLoading) {
              return const CustomLoading();
            }
            if (state is DatesFailure) {
              return CustomError(errMessage: state.errMessage);
            }
            if (state is DatesSuccess) {
              if (state.dates.isEmpty) {
                return Center(
                    child: Center(child: Text(S.of(context).thereIsNoOrders)));
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: state.dates.length,
                  itemBuilder: (context, index) {
                    return DateListViewItem(
                      date: state.dates[state.dates.length - index - 1],
                    );
                  },
                ),
              );
            }

            return Center(child: Text(S.of(context).thereIsNoOrders));

            // return Expanded(
            //   child: ListView.builder(
            //     itemCount: 5,
            //     itemBuilder: (context, index) {
            //       return Card(
            //         child: ListTile(
            //           title: const Text('state.clients[index].clientName!'),
            //           onTap: () {
            //             //todo navigate to detalis
            //           //  context.go('location');
            //           },
            //         ),
            //       );
            //     },
            //   ),
            // );
          },
        ),
        AuthButton(
            onPressed: () {
              context.push(AppRouter.kQuantityReportFromDate, extra: '12/2023');
            },
            text: "goooooo")
      ],
    );
  }
}
