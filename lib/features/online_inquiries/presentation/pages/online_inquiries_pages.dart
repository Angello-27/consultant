// lib/features/online_inquiries/presentation/pages/online_inquiries_pages.dart
import 'package:flutter/material.dart';

import '../widgets/organisms/conversation_view.dart';
import '../widgets/organisms/input_area.dart';
import '../widgets/molecules/server_config_dialog.dart';
import '../../../../core/constants/app_text_constants.dart';
import '../../../../core/constants/app_color_constants.dart';

class OnlineInquiriesPages extends StatelessWidget {
  const OnlineInquiriesPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppText.queryScreenTitle,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.primaryColor,
        actions: [
          // Icono para abrir diálogo de configuración de IP
          IconButton(
            icon: const Icon(Icons.settings),
            color: Colors.white,
            onPressed: () {
              // Muestra el diálogo de configuración de servidor
              showDialog(
                context: context,
                builder: (_) => const ServerConfigDialog(),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: const [Expanded(child: ConversationView()), InputArea()],
      ),
    );
  }
}
