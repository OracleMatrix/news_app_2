import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class InternetStatusProvider extends ChangeNotifier {
  bool _isConnected = true;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  bool get isConnected => _isConnected;

  InternetStatusProvider() {
    _initializeConnectivity();
  }

  Future<void> _initializeConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);
    _subscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    _isConnected = result.isNotEmpty && result.first != ConnectivityResult.none;
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
