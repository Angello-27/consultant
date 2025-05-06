// lib/features/online_inquiries/presentation/widgets/molecules/server_config_dialog.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/configs/network_config.dart';

/// Diálogo para configurar (ver/editar) la URL del servidor dinámico.
class ServerConfigDialog extends StatelessWidget {
  const ServerConfigDialog({super.key});

  @override
  Widget build(BuildContext context) {
    // Servicio que guarda la URL
    final config = context.read<NetworkConfig>();
    // Precargo la URL actual en el controlador
    final controller = TextEditingController(text: config.serverUrl);

    return AlertDialog(
      title: const Text('Configurar servidor'),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
          labelText: 'URL del servidor',
          hintText: 'http://IP:puerto',
        ),
        keyboardType: TextInputType.url,
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Cierra el diálogo
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            final newUrl = controller.text.trim();
            Navigator.of(context).pop(); // Cerramos inmediatamente

            if (newUrl.isNotEmpty) {
              // Capturamos el messenger _antes_ del async
              final messenger = ScaffoldMessenger.of(context);
              // Guardamos la nueva URL (async) y luego mostramos el SnackBar
              config.updateServerUrl(newUrl).then((_) {
                messenger.showSnackBar(
                  const SnackBar(content: Text('URL de servidor actualizada')),
                );
              });
            }
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
