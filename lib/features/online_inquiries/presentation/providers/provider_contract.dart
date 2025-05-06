// lib/features/online_inquiries/presentation/providers/provider_contract.dart
import 'package:flutter/foundation.dart';
import '../../domain/entities/online_inquiries_response.dart';

// La abstracción que tu UI va a consumir extiende ChangeNotifier para poder usarla.
abstract class IOnlineInquiriesProviderContract extends ChangeNotifier {
  String? get error;
  bool get isLoading;
  OnlineInquiriesResponse? get response;
  Future<void> send(String query);
}
