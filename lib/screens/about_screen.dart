import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void>? _launched;

    Future<void> _launchUniversalLinkIos(Uri url) async {
      final bool nativeAppLaunchSucceeded = await launchUrl(
        url,
        mode: LaunchMode.externalNonBrowserApplication,
      );
      if (!nativeAppLaunchSucceeded) {
        await launchUrl(
          url,
          mode: LaunchMode.inAppWebView,
        );
      }
    }

    Future<void> _launchInBrowser(Uri url) async {
      if (!await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      )) {
        throw Exception('Could not launch $url');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(height: 24),
            Image.asset(
              "assets/images/profile_icon.png",
              height: 200,
            ),
            SizedBox(height: 15),
            Text(
              "@iamsmruti",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Text(
              "Software Engineer(React/Node/Flutter)",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            SizedBox(height: 7),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "I love creating web and mobile apps with beautiful UI.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.pinkAccent,
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(height: 32),
            Text(
              "Social Links",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              color: Colors.pinkAccent,
              thickness: 2,
              indent: 100,
              endIndent: 100,
            ),
            SizedBox(height: 15),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              IconButton(
                onPressed: () => _launched = _launchInBrowser(
                  Uri.parse("https://github.com/iamsmruti/"),
                ),
                icon: Image.asset(
                  "assets/images/github.png",
                  height: 30,
                ),
              ),
              IconButton(
                onPressed: () => _launched = _launchInBrowser(
                  Uri.parse("https://www.linkedin.com/in/iamsmruti/"),
                ),
                icon: Image.asset(
                  "assets/images/linkedin.png",
                  height: 30,
                ),
              ),
              IconButton(
                onPressed: () => _launched = _launchInBrowser(
                  Uri.parse("https://twitter.com/__iamsmruti"),
                ),
                icon: Image.asset(
                  "assets/images/twitter.png",
                  height: 30,
                ),
              ),
              IconButton(
                onPressed: () => _launched = _launchInBrowser(
                  Uri.parse("https://www.instagram.com/__iamsmruti/"),
                ),
                icon: Image.asset(
                  "assets/images/instagram.png",
                  height: 30,
                ),
              )
            ])
          ]),
        ),
      ),
    );
  }
}
