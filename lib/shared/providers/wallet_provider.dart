import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/wallet_package.dart';

final walletCreditsProvider = StateProvider<int>((ref) => 5);

final walletPackagesProvider = Provider<List<WalletPackage>>((ref) {
  return const [
    WalletPackage(id: 'pkg_5', minutes: 5, price: 1.99),
    WalletPackage(id: 'pkg_10', minutes: 10, price: 3.49),
    WalletPackage(id: 'pkg_30', minutes: 30, price: 8.99),
  ];
});
