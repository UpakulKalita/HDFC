import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurance_flutter/core/constants/app_colors.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/sidebar_widget.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _emailNotifications = true;
  bool _smsNotifications = false;
  bool _pushNotifications = true;
  bool _marketingEmails = false;
  String _language = 'English';
  String _theme = 'Light';

  void _onSidebarItemTap(String item) {
    // Handle navigation based on the selected item
    switch (item) {
      case 'Dashboard':
        Navigator.of(context).pushNamed('/dashboard');
        break;
      case 'Health Plans':
        Navigator.of(context).pushNamed('/health-plans');
        break;
      case 'Term Life Plans':
        Navigator.of(context).pushNamed('/term-plans');
        break;
      case 'Auto Insurance':
        Navigator.of(context).pushNamed('/life-insurance');
        break;
      case 'Get Help':
        Navigator.of(context).pushNamed('/get-help');
        break;
      case 'Settings':
        // Already on this page
        break;
      case 'Profile':
        Navigator.of(context).pushNamed('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 800;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.grey.shade50,
            child: Row(
              children: [
                if (isDesktop) ...[
                  /// LEFT SIDEBAR - Full Height (Desktop only)
                  SidebarWidget(
                    activeItem: 'Settings',
                    onItemTap: _onSidebarItemTap,
                  ),
                ],

                /// MAIN CONTENT AREA
                Expanded(
                  child: Column(
                    children: [
                      /// TOP BAR
                      _buildTopBar(context, isDesktop: isDesktop),

                      /// MAIN CONTENT
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(32),
                            child: Container(
                              constraints: const BoxConstraints(maxWidth: 1000),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Page Header
                                  Text(
                                    'Settings',
                                    style: GoogleFonts.inter(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Manage your account preferences and settings',
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 32),

                                  // Account Settings
                                  _buildSettingsSection(
                                    title: 'Account Settings',
                                    children: [
                                      _buildSettingsItem(
                                        icon: LucideIcons.user,
                                        title: 'Personal Information',
                                        subtitle: 'Update your name, email, and contact details',
                                        onTap: () {},
                                      ),
                                      _buildSettingsItem(
                                        icon: LucideIcons.lock,
                                        title: 'Password & Security',
                                        subtitle: 'Change password and security settings',
                                        onTap: () {},
                                      ),
                                      _buildSettingsItem(
                                        icon: LucideIcons.creditCard,
                                        title: 'Payment Methods',
                                        subtitle: 'Manage your saved payment methods',
                                        onTap: () {},
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 32),

                                  // Notification Settings
                                  _buildSettingsSection(
                                    title: 'Notifications',
                                    children: [
                                      _buildSwitchItem(
                                        title: 'Email Notifications',
                                        subtitle: 'Receive policy updates and important alerts via email',
                                        value: _emailNotifications,
                                        onChanged: (value) => setState(() => _emailNotifications = value),
                                      ),
                                      _buildSwitchItem(
                                        title: 'SMS Notifications',
                                        subtitle: 'Get text messages for urgent updates',
                                        value: _smsNotifications,
                                        onChanged: (value) => setState(() => _smsNotifications = value),
                                      ),
                                      _buildSwitchItem(
                                        title: 'Push Notifications',
                                        subtitle: 'Receive notifications on your device',
                                        value: _pushNotifications,
                                        onChanged: (value) => setState(() => _pushNotifications = value),
                                      ),
                                      _buildSwitchItem(
                                        title: 'Marketing Emails',
                                        subtitle: 'Receive promotional offers and updates',
                                        value: _marketingEmails,
                                        onChanged: (value) => setState(() => _marketingEmails = value),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 32),

                                  // Preferences
                                  _buildSettingsSection(
                                    title: 'Preferences',
                                    children: [
                                      _buildDropdownItem(
                                        icon: LucideIcons.languages,
                                        title: 'Language',
                                        value: _language,
                                        items: ['English', 'Hindi', 'Marathi', 'Gujarati'],
                                        onChanged: (value) => setState(() => _language = value!),
                                      ),
                                      _buildDropdownItem(
                                        icon: LucideIcons.palette,
                                        title: 'Theme',
                                        value: _theme,
                                        items: ['Light', 'Dark', 'System'],
                                        onChanged: (value) => setState(() => _theme = value!),
                                      ),
                                      _buildSettingsItem(
                                        icon: LucideIcons.globe,
                                        title: 'Region & Currency',
                                        subtitle: 'India (INR) - Change region settings',
                                        onTap: () {},
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 32),

                                  // Privacy & Security
                                  _buildSettingsSection(
                                    title: 'Privacy & Security',
                                    children: [
                                      _buildSettingsItem(
                                        icon: LucideIcons.shield,
                                        title: 'Privacy Settings',
                                        subtitle: 'Control your data and privacy preferences',
                                        onTap: () {},
                                      ),
                                      _buildSettingsItem(
                                        icon: LucideIcons.key,
                                        title: 'Two-Factor Authentication',
                                        subtitle: 'Add an extra layer of security to your account',
                                        onTap: () {},
                                      ),
                                      _buildSettingsItem(
                                        icon: LucideIcons.download,
                                        title: 'Download My Data',
                                        subtitle: 'Request a copy of your personal data',
                                        onTap: () {},
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 32),

                                  // Danger Zone
                                  Container(
                                    padding: const EdgeInsets.all(24),
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade50,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: Colors.red.shade200),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Danger Zone',
                                          style: GoogleFonts.inter(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red.shade700,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          'These actions cannot be undone. Please proceed with caution.',
                                          style: GoogleFonts.inter(
                                            fontSize: 14,
                                            color: Colors.red.shade600,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        OutlinedButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: Text(
                                                  'Delete Account',
                                                  style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                                                ),
                                                content: Text(
                                                  'Are you sure you want to delete your account? This action cannot be undone.',
                                                  style: GoogleFonts.inter(),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () => Navigator.of(context).pop(),
                                                    child: Text(
                                                      'Cancel',
                                                      style: GoogleFonts.inter(),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      // Handle account deletion
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Text(
                                                      'Delete',
                                                      style: GoogleFonts.inter(color: Colors.red),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          style: OutlinedButton.styleFrom(
                                            side: BorderSide(color: Colors.red.shade300),
                                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                                          ),
                                          child: Text(
                                            'Delete Account',
                                            style: GoogleFonts.inter(
                                              color: Colors.red.shade700,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: isDesktop ? null : SidebarWidget(
        activeItem: 'Settings',
        onItemTap: _onSidebarItemTap,
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, {required bool isDesktop}) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 70,
      backgroundColor: Colors.white,
      leading: isDesktop ? null : Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.black87),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: Container(
        width: isDesktop ? 400 : 280,
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.grey.shade600, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: isDesktop ? 'Search settings...' : 'Search...',
                  border: InputBorder.none,
                  hintStyle: GoogleFonts.inter(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
                style: GoogleFonts.inter(
                  color: Colors.black87,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications, color: Colors.black87, size: 24),
          onPressed: () {},
          tooltip: 'Notifications',
        ),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.person, color: Colors.black87, size: 20),
          label: Text(
            'My Profile',
            style: GoogleFonts.inter(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: Icon(Icons.logout, color: Colors.red.shade700, size: 20),
          onPressed: () {},
          tooltip: 'Logout',
        ),
        const SizedBox(width: 12),
      ],
    );
  }

  Widget _buildSettingsSection({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade100, width: 1),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: Colors.grey.shade700,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey.shade400,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchItem({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade100, width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownItem({
    required IconData icon,
    required String title,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade100, width: 1),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: Colors.grey.shade700,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: value,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppColors.primary),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  items: items.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(
                        item,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: onChanged,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
