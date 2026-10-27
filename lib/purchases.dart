import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Product id to create in Google Play Console / App Store Connect
/// (one-time "non-consumable" purchase).
const removeAdsProductId = 'remove_ads';

const _prefsKey = 'adsRemoved';

/// True once the user has bought "remove ads" (or it was restored).
final adsRemoved = ValueNotifier<bool>(false);

/// Localised price from the store, e.g. "2,99 €"; null when the store has no such product.
final removeAdsPrice = ValueNotifier<String?>(null);

ProductDetails? _product;
StreamSubscription<List<PurchaseDetails>>? _sub;

/// Loads the saved flag first (so no ad ever flashes for a buyer), then asks the
/// store. Safe everywhere: on desktop or without store access it does nothing.
Future<void> initPurchases() async {
  if (!(Platform.isAndroid || Platform.isIOS)) return;
  final prefs = await SharedPreferences.getInstance();
  adsRemoved.value = prefs.getBool(_prefsKey) ?? false;

  final store = InAppPurchase.instance;
  if (!await store.isAvailable()) return;
  _sub ??= store.purchaseStream.listen(_onPurchases, onError: (Object e) => debugPrint('purchases: $e'));

  final found = await store.queryProductDetails({removeAdsProductId});
  if (found.productDetails.isNotEmpty) {
    _product = found.productDetails.first;
    removeAdsPrice.value = _product!.price;
  }
  await store.restorePurchases(); // a new phone gets its purchase back without paying again
}

/// Starts the store's payment sheet. The result arrives through the purchase stream.
Future<void> buyRemoveAds() async {
  final product = _product;
  if (product == null) return;
  await InAppPurchase.instance.buyNonConsumable(purchaseParam: PurchaseParam(productDetails: product));
}

Future<void> restorePurchases() => InAppPurchase.instance.restorePurchases();

Future<void> _onPurchases(List<PurchaseDetails> purchases) async {
  for (final p in purchases) {
    if (p.productID != removeAdsProductId) continue;
    if (p.status == PurchaseStatus.purchased || p.status == PurchaseStatus.restored) {
      adsRemoved.value = true;
      await (await SharedPreferences.getInstance()).setBool(_prefsKey, true);
    }
    // the store refunds a purchase that is never acknowledged
    if (p.pendingCompletePurchase) await InAppPurchase.instance.completePurchase(p);
  }
}
