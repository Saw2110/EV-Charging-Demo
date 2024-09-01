import 'package:url_launcher/url_launcher.dart';

extension LaunchExtention on String {
  ///
  /// [ launchInBrowser ]
  Future<void> launchInBrowser({bool isInAppView = false}) async {
    final Uri url = Uri.parse(this);
    if (!await launchUrl(
      url,
      mode: isInAppView
          ? LaunchMode.inAppWebView
          : LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $this');
    }
  }

  ///
  /// [ sendEmail ]
  Future<void> sendEmail() async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: this,
    );
    await launchUrl(launchUri);
  }

  ///
  /// [ makePhoneCall ]
  Future<void> makePhoneCall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: this,
    );
    await launchUrl(launchUri);
  }
}
