import 'dart:async';
import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'purchases.dart';

// Google's public TEST banner units. Replace with the real AdMob ids before
// release (and the app ids in AndroidManifest.xml / Info.plist).
const _bannerAndroid = 'ca-app-pub-3940256099942544/6300978111';
const _bannerIos = 'ca-app-pub-3940256099942544/2934735716';

/// True once consent allows requesting ads and the SDK is initialised.
final adsReady = ValueNotifier<bool>(false);

/// True when the user must be able to reopen the consent choices (GDPR).
final privacyOptionsRequired = ValueNotifier<bool>(false);

bool get _adsSupported => Platform.isAndroid || Platform.isIOS;

/// Order matters: GDPR consent first, then the iOS tracking prompt, then
/// the SDK. No ad is requested unless consent allows it.
Future<void> initAds() async {
  if (!_adsSupported || adsRemoved.value) return; // buyers see no ad and no consent form
  await _gatherConsent();
  if (Platform.isIOS) await _askTracking();
  if (await ConsentInformation.instance.canRequestAds()) {
    await MobileAds.instance.initialize();
    adsReady.value = true;
  }
  privacyOptionsRequired.value = await ConsentInformation.instance
          .getPrivacyOptionsRequirementStatus() ==
      PrivacyOptionsRequirementStatus.required;
}

Future<void> _gatherConsent() {
  final done = Completer<void>();
  ConsentInformation.instance.requestConsentInfoUpdate(
    ConsentRequestParameters(),
    () => ConsentForm.loadAndShowConsentFormIfRequired((_) => done.complete()),
    (_) => done.complete(), // offline etc.: canRequestAds() decides afterwards
  );
  return done.future;
}

Future<void> _askTracking() async {
  if (await AppTrackingTransparency.trackingAuthorizationStatus ==
      TrackingStatus.notDetermined) {
    await AppTrackingTransparency.requestTrackingAuthorization();
  }
}

void showPrivacyOptions() => ConsentForm.showPrivacyOptionsForm((_) {});

/// Small banner; takes no space until an ad has loaded (and never on desktop).
class AdBanner extends StatefulWidget {
  const AdBanner({super.key});

  @override
  State<AdBanner> createState() => _AdBannerState();
}

class _AdBannerState extends State<AdBanner> {
  BannerAd? _ad;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    adsReady.addListener(_load);
    _load();
  }

  void _load() {
    if (!adsReady.value || _ad != null) return;
    _ad = BannerAd(
      adUnitId: Platform.isIOS ? _bannerIos : _bannerAndroid,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) => setState(() => _loaded = true),
        onAdFailedToLoad: (ad, _) {
          ad.dispose();
          _ad = null;
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    adsReady.removeListener(_load);
    _ad?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<bool>(
        valueListenable: adsRemoved,
        builder: (context, removed, _) {
          final ad = _ad;
          if (removed || !_loaded || ad == null) return const SizedBox.shrink();
          return SafeArea(
            child: SizedBox(width: ad.size.width.toDouble(), height: ad.size.height.toDouble(), child: AdWidget(ad: ad)),
          );
        },
      );
}
