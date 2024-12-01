import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // For launching URLs

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  // Function to launch URL
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            const Text(
              "About This App",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),

            // App Description
            const Text(
              "This is a news aggregation app where you can read the latest news from various categories such as General, Technology, Business, and more. The app fetches news from a reliable API and displays them in an easy-to-read format. Enjoy staying updated with the latest happenings around the world!",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 24),

            // Author Section
            const Text(
              "About the Author",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Hi, I'm Alfred Rajendra WIjaya, as the creator of this app. I'm passionate about mobile app development and enjoy creating tools that help users stay informed. Feel free to reach out to me through any of the social links below.",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 24),

            // Social Links
            const Text(
              "Connect with me:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),

            // Instagram
            InkWell(
              onTap: () => _launchURL(
                  'https://www.instagram.com/alfrrrrd_'), // Replace with your Instagram URL
              child: Row(
                children: const [
                  Icon(Icons.camera_alt, color: Colors.purple),
                  SizedBox(width: 8),
                  Text(
                    "Instagram",
                    style: TextStyle(fontSize: 16, color: Colors.purple),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Facebook
            InkWell(
              onTap: () => _launchURL(
                  'https://www.facebook.com/Wijay.AlKhabbany?_rdr'), // Replace with your Facebook URL
              child: Row(
                children: const [
                  Icon(Icons.facebook, color: Colors.blue),
                  SizedBox(width: 8),
                  Text(
                    "Facebook",
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // GitHub
            InkWell(
              onTap: () => _launchURL(
                  'https://github.com/ipinlearn4code'), // Replace with your GitHub URL
              child: Row(
                children: const [
                  Icon(Icons.code, color: Colors.black),
                  SizedBox(width: 8),
                  Text(
                    "GitHub",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
