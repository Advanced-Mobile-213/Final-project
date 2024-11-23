import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  late bool isLoggingOut;

  @override void initState() {
    super.initState();
    // TODO: implement initState
    isLoggingOut = false;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackground,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: AppColors.quaternaryText,
          ),
        ),
      ),
      body: Container(
        color: AppColors.primaryBackground,
        child: Row(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: <Widget>[
                    // Profile Section
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: <Widget>[
                          const Icon(
                            Icons.account_circle,
                            size: 50,
                            color: AppColors.quaternaryText,
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              // Add your onPressed code here if necessary
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(AppColors.primaryBackground),
                            ),
                            child: Text(
                              context.watch<AuthProvider>().user!.username,
                              style: const TextStyle(
                                color: AppColors.quaternaryText,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            context.watch<AuthProvider>().user!.email,
                            style: const TextStyle(
                              color: AppColors.quaternaryText,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Subscription Plan Section
                    Container(
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.secondaryBackground,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.quaternaryBackground,
                      ),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: const Icon(FontAwesomeIcons.infinity),
                            title: const Text(
                              'Premium Plan',
                              style: TextStyle(
                                color: AppColors.primaryText,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: TextButton(
                              onPressed: () {
                                // Add your onPressed code here
                              },
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(AppColors.primaryBackground),
                              ),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                  color: AppColors.quaternaryText,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          const ListTile(
                            leading: Text(
                              'Tokens',
                              style: TextStyle(
                                fontSize: 20,
                                color: AppColors.primaryText,
                              ),
                            ),
                            trailing: Text(
                              'Unlimited',
                              style: TextStyle(
                                fontSize: 20,
                                color: AppColors.primaryText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Free Plan Section
                    Container(
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.secondaryBackground,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.quaternaryBackground,
                      ),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: const Icon(Icons.lock),
                            title: const Text(
                              'Free Plan',
                              style: TextStyle(
                                color: AppColors.primaryText,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/subscription');
                              },
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(AppColors.primaryBackground),
                              ),
                              child: const Text(
                                'Upgrade',
                                style: TextStyle(
                                  color: AppColors.quaternaryText,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          const ListTile(
                            leading: Text(
                              'Tokens',
                              style: TextStyle(
                                fontSize: 20,
                                color: AppColors.primaryText,
                              ),
                            ),
                            trailing: Text(
                              '30/50',
                              style: TextStyle(
                                fontSize: 20,
                                color: AppColors.primaryText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // General Section
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'General',
                            style: TextStyle(
                              color: AppColors.tertiaryText,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Chat Settings
                          ListTile(
                            tileColor: AppColors.primaryBackground,
                            leading: const Icon(
                              Icons.settings,
                              color: AppColors.quaternaryText,
                            ),
                            title: const Text(
                              'Chat Settings',
                              style: TextStyle(
                                color: AppColors.quaternaryText,
                                fontSize: 20,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.quaternaryText,
                            ),
                            onTap: () {
                              // Add your onPressed code here
                            },
                          ),
                          // Color Scheme
                          ListTile(
                            tileColor: AppColors.primaryBackground,
                            leading: const Icon(
                              Icons.dark_mode,
                              color: AppColors.quaternaryText,
                            ),
                            title: const Text(
                              'Color Scheme',
                              style: TextStyle(
                                color: AppColors.quaternaryText,
                                fontSize: 20,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.quaternaryText,
                            ),
                            onTap: () {
                              // Add your onPressed code here
                            },
                          ),
                          // Language
                          ListTile(
                            tileColor: AppColors.primaryBackground,
                            leading: const Icon(
                              FontAwesomeIcons.globe,
                              color: AppColors.quaternaryText,
                            ),
                            title: const Text(
                              'Language',
                              style: TextStyle(
                                color: AppColors.quaternaryText,
                                fontSize: 20,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.quaternaryText,
                            ),
                            onTap: () {
                              // Add your onPressed code here
                            },
                          ),
                          // Logout
                          ListTile(
                            tileColor: AppColors.primaryBackground,
                            leading: const Icon(
                              FontAwesomeIcons.doorOpen,
                              color: AppColors.quaternaryText,
                            ),
                            title: const Text(
                              'Logout',
                              style: TextStyle(
                                color: AppColors.quaternaryText,
                                fontSize: 20,
                              ),
                            ),
                            trailing: isLoggingOut
                                ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.quaternaryText,
                              ),
                            )
                                : const Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.quaternaryText,
                            ),
                            onTap: isLoggingOut
                                ? null
                                : () async {
                              setState(() {
                                isLoggingOut = true;
                              });

                              await authProvider.logout();

                              if (!mounted) return;

                              setState(() {
                                isLoggingOut = false;
                              });

                              Navigator.pushReplacementNamed(
                                  context, '/login');
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
