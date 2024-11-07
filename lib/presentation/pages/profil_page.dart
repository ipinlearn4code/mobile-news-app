import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Stack(children: [
          Column(
            children: [
              // Profile Card
              Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    // Profile Image
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                          'https://via.placeholder.com/150'), // Replace with actual image URL
                    ),
                    SizedBox(width: 16),
                    // User Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Itunuoluwa Abidoye',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '@itunuoluwa',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Edit Icon
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.white),
                      onPressed: () {
                        // Handle edit profile
                      },
                    ),
                  ],
                ),
              ),

              // Settings Options
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildSettingsOption(
                      context,
                      icon: Icons.person_outline,
                      title: 'My Account',
                      subtitle: 'Make changes to your account',
                      trailing: Icon(Icons.error, color: Colors.red),
                    ),
                    _buildSettingsOption(
                      context,
                      icon: Icons.account_balance_wallet_outlined,
                      title: 'Saved Beneficiary',
                      subtitle: 'Manage your saved account',
                    ),
                    _buildSettingsOption(
                      context,
                      icon: Icons.fingerprint,
                      title: 'Face ID / Touch ID',
                      subtitle: 'Manage your device security',
                      trailing: Switch(
                        value: false,
                        onChanged: (bool value) {
                          // Handle switch toggle
                        },
                      ),
                    ),
                    _buildSettingsOption(
                      context,
                      icon: Icons.lock_outline,
                      title: 'Two-Factor Authentication',
                      subtitle: 'Further secure your account for safety',
                    ),
                    _buildSettingsOption(
                      context,
                      icon: Icons.logout,
                      title: 'Log out',
                      subtitle: 'Further secure your account for safety',
                    ),
                  ],
                ),
              ),

              // More Section
              SizedBox(height: 16),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildSettingsOption(
                      context,
                      icon: Icons.help_outline,
                      title: 'Help & Support',
                      subtitle: 'Get help or report an issue',
                    ),
                    _buildSettingsOption(
                      context,
                      icon: Icons.info_outline,
                      title: 'About App',
                      subtitle: 'Learn more about this app',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  Widget _buildSettingsOption(BuildContext context,
      {required IconData icon,
      required String title,
      required String subtitle,
      Widget? trailing}) {
    return ListTile(
      leading: Icon(icon, color: Colors.indigo),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: trailing ?? Icon(Icons.chevron_right),
      onTap: () {
        // Handle option tap
      },
    );
  }
}
