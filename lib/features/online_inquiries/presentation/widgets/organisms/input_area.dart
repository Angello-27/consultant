// lib/features/online_inquiries/presentation/widgets/organisms/input_area.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../molecules/input_actions.dart';
import '../atoms/expandable_text_field.dart';
import '../../../presentation/providers/provider_contract.dart';
import '../../../../../core/constants/app_text_constants.dart';

class InputArea extends StatefulWidget {
  const InputArea({super.key});

  @override
  State<InputArea> createState() => _InputAreaState();
}

class _InputAreaState extends State<InputArea> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Aquí uso la abstracción, no la implementación concreta
    final prov = Provider.of<IOnlineInquiriesProviderContract>(
      context,
      listen: false,
    );

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: ExpandableTextField(
              controller: _controller,
              hint: AppText.queryFieldLabel,
            ),
          ),
          const SizedBox(width: 8),
          InputActions(
            onMic: () async {
              // abrir modal con SpeechInputWidget y luego:
              // setState(() => _controller.text = recognizedText);
            },
            onSend: () {
              final query = _controller.text.trim();
              if (query.isNotEmpty) {
                prov.send(query);
                _controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
