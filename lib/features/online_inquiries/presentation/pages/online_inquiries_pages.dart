// lib/features/online_inquiries/presentation/pages/online_inquiries_pages.dart
import 'package:flutter/material.dart';

import '../widgets/organisms/conversation_view.dart';
import '../widgets/organisms/input_area.dart';
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
      ),
      body: Column(
        children: const [Expanded(child: ConversationView()), InputArea()],
      ),
    );
  }
}
