import 'package:chatbot_agents/constants/ad_unit_id.dart';
import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/provider/auth_provider.dart';
import 'package:chatbot_agents/view_models/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  late bool isLoggingOut;
  late final ProfileViewModel _profileViewModel;

  // ads
  final String adUnitId = AdUnitId.bannerAdUnitId;
  AdSize adSize = AdSize.banner;
  
  /// The banner ad to show. This is `null` until the ad is actually loaded.
  BannerAd? _bannerAd;

  @override void initState() {
    super.initState();
    isLoggingOut = false;
    _profileViewModel = context.read<ProfileViewModel>();
    _fetchTokenUsage();
    _loadAd();
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

                    // Ads Section
                    SizedBox(
                      width: adSize.width.toDouble(),
                      height: adSize.height.toDouble(),
                      child: _bannerAd == null
                          // Nothing to render yet.
                          ? const SizedBox()
                          // The actual ad.
                          : AdWidget(ad: _bannerAd!),
                    ),

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
                    Consumer<ProfileViewModel>(
                      builder: (context, ProfileViewModel profileViewModel, child) {
                        if (profileViewModel.isLoading == true) {
                          return const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.quaternaryBackground,
                            );

                        } else if (profileViewModel.isPremiumUser == true) {
                          // Subscription Plan Section
                          return Container(
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
                          );
                              
                        } else if (profileViewModel.isPremiumUser == false) {
                          // Free Plan Section
                          return Container(
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
                                    onPressed: () async {
                                      // log event and send to google analytics
                                      await profileViewModel.logEvent(
                                        eventName: 'user_click_upgrade_subscription',
                                        parameters: {
                                          'username': context.read<AuthProvider>().user!.username,
                                          'email': context.read<AuthProvider>().user!.email,
                                          'available_tokens': profileViewModel.tokenUsageResponse!.availableTokens,
                                        },
                                      );
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
                                ListTile(
                                  leading: const Text(
                                    'Tokens',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: AppColors.primaryText,
                                    ),
                                  ),
                                  trailing: Text(
                                    '${profileViewModel.tokenUsageResponse!.availableTokens}/${profileViewModel.tokenUsageResponse!.totalTokens}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: AppColors.primaryText,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                    
                        }
                        
                        return Container(
                          child: Text(
                            'An error occurred',
                            style: TextStyle(
                              color: AppColors.quaternaryText,
                              fontSize: 20,
                            ),
                          ),
                        );
                      }
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

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  void _fetchTokenUsage() async {
    await _profileViewModel.checkIsPremiumUser();
  }

  /// Loads a banner ad.
  void _loadAd() {
    final bannerAd = BannerAd(
      size: adSize,
      adUnitId: adUnitId,
      request: const AdRequest(),
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, error) {
          debugPrint('BannerAd failed to load: $error');
          ad.dispose();
        },
      ),
    );

    // Start loading.
    bannerAd.load();
  }
  
}
