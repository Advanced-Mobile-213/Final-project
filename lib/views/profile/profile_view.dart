import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileView extends StatefulWidget {
 
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackground,
        title: Text('Profile',
            style: const TextStyle(
                color: AppColors.quaternaryText,
            )
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
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Column(
                          children: <Widget>[
                            (true)
                                ? Icon(Icons.account_circle, size:50, color: AppColors.quaternaryText)
                                : CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage('assets/images/profile.jpg'),
                            ),

                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: ElevatedButton(
                                onPressed: () {
                                  // Add your onPressed code here!
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text('John Doe',
                                        style: const TextStyle(
                                            color: AppColors.quaternaryText,
                                            fontSize: 20
                                        )
                                    ),
                                    Icon(Icons.arrow_forward_ios,
                                        color: AppColors.quaternaryText,
                                    ),
                                  ],
                                ),
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(AppColors.primaryBackground),
                                ),
                              ),
                            ),

                            Text('Example@gmail.com',
                                style: const TextStyle(
                                    color: AppColors.quaternaryText,
                                    fontSize: 20
                                )
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
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
                              title: const Text('Premium Plan',
                                  style: const TextStyle(
                                      color: AppColors.primaryText,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                  )
                              ),
                              trailing: TextButton(
                                onPressed: () {
                                  // Add your onPressed code here!
                                },
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(AppColors.tertiaryBackground),
                                ),
                                child: const Text('Cancel',
                                    style: const TextStyle(
                                        color: AppColors.quaternaryText,
                                        fontSize: 20,
                                    )
                                ),
                              ),
                            ),
                            ListTile(
                              leading: Text('Tokens',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: AppColors.primaryText,
                                  )
                              ),
                              trailing: Text('Unlimited',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: AppColors.primaryText,
                                  )
                              ),
                            ),
                          ],
                        ),

                      ),
                      Container(
                        margin: EdgeInsets.all(20),
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
                              leading: Icon(Icons.lock),
                              title: const Text('Free Plan',
                                  style: const TextStyle(
                                      color: AppColors.primaryText,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                  )
                              ),
                              trailing: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/subscription');
                                },
                                style:  ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(AppColors.tertiaryBackground),
                                ),
                                child: const Text('Upgrade',
                                    style: const TextStyle(
                                        color: AppColors.quaternaryText,
                                        fontSize: 20,
                                    )
                                ),
                              ),
                            ),
                            ListTile(
                              leading: const Text('Tokens',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: AppColors.primaryText,
                                  )
                              ),
                              trailing: Text('30/50',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: AppColors.primaryText,
                                  )
                              ),
                            ),
                          ],
                        ),

                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text('General',
                                style: TextStyle(
                                    color: AppColors.tertiaryText,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                )
                            ),
                            
                            
                            Container(
                                child: ListTile(
                                  tileColor: AppColors.primaryBackground,
                                  leading: Icon(Icons.settings,
                                      color: AppColors.quaternaryText
                                  ),
                                  title: const Text('Chat Settings',
                                      style: const TextStyle(
                                          color: AppColors.quaternaryText,
                                          fontSize: 20,
                                      )
                                  ),
                                  trailing: Icon(Icons.arrow_forward_ios,
                                      color: AppColors.quaternaryText,
                                  ),
                                  onTap: () {
                                    // Add your onPressed code here!
                                  },
                                ),
                            ),
                            Container(
                                child: ListTile(
                                  tileColor: AppColors.primaryBackground,
                                  leading: Icon(Icons.dark_mode,
                                    color: AppColors.quaternaryText
                                  ),
                                  title: const Text('Color Scheme',
                                      style: const TextStyle(
                                          color: AppColors.quaternaryText,
                                          fontSize: 20,
                                      )
                                  ),
                                  trailing: Icon(Icons.arrow_forward_ios,
                                      color: AppColors.quaternaryText
                                  ),
                                  onTap: () {
                                    // Add your onPressed code here!
                                  },
                                ),
                            ),
                            Container(
                                child: ListTile(
                                  tileColor: AppColors.primaryBackground,
                                  leading: Icon(FontAwesomeIcons.globe,
                                      color: AppColors.quaternaryText
                                  ),
                                  title: const Text('Language',
                                      style: const TextStyle(
                                          color: AppColors.quaternaryText,
                                          fontSize: 20,
                                      )
                                  ),
                                  trailing: Icon(Icons.arrow_forward_ios,
                                      color: AppColors.quaternaryText
                                  ),
                                  onTap: () {
                                    // Add your onPressed code here!
                                  },
                                ),
                            ),
                          ],
                        ),

                      ),
                    ],
                  ),
                )
            ),
          ],
        ),
      )
    );
  }
  
}

