import 'package:flutter/material.dart';
import 'package:pharmazon_web/features/home/presentation/views/widgets/home_drawer.dart';

import 'widgets/clients_view_body.dart';

class ClientsView extends StatelessWidget {
  const ClientsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ClientsViewBody(),
    );
  }
}
