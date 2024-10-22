import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/app_colors.dart';

class SubscriptionView extends StatefulWidget {

  SubscriptionView({Key? key}) : super(key: key);
  @override
  State<SubscriptionView> createState() => _SubscriptionViewState();
}

List<String> options = ['1','2'];

class _SubscriptionViewState extends State<SubscriptionView>{

  bool switchValue = false;
  String currentOption = options[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackground,
        title: const Text('Upgrade PRO',
            style: TextStyle(
                color: AppColors.quaternaryText
            )
        ),
      ),
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                color: AppColors.primaryBackground,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(20),
                      child: const Column(
                        children: <Widget>[
                          Card(
                            color: AppColors.secondaryBackground,
                            child: ListTile(
                              title: Text('Access to ChatGPT-4o',
                                  style: const TextStyle(
                                      color: AppColors.quaternaryText,
                                      fontSize: 20
                                  )
                              ),
                              subtitle: Text('More accurate and detailed answers',
                                  style: const TextStyle(
                                      color: AppColors.quaternaryText,
                                      fontSize: 15
                                  )
                              ),
                              leading: Icon(FontAwesomeIcons.robot,
                                color: AppColors.quaternaryText,
                              ),
                            ),
                          ),
                          Card(
                            color: AppColors.secondaryBackground,
                            child: ListTile(
                              title: Text('Unlimited Web Access',
                                  style: const TextStyle(
                                      color: AppColors.quaternaryText,
                                      fontSize: 20
                                  )
                              ),
                              subtitle: Text('Query data from any website',
                                  style: const TextStyle(
                                      color: AppColors.quaternaryText,
                                      fontSize: 15
                                  )
                              ),
                              leading: Icon(FontAwesomeIcons.globe,
                                color: AppColors.quaternaryText,
                              ),
                            ),
                          ),
                          Card(
                            color: AppColors.secondaryBackground,
                            child: ListTile(
                              title: Text('Unlimited AI-powered smart summarization',
                                  style: const TextStyle(
                                      color: AppColors.quaternaryText,
                                      fontSize: 20
                                  )
                              ),
                              subtitle: Text('For any webpage, YouTube video, and PDF file',
                                  style: const TextStyle(
                                      color: AppColors.quaternaryText,
                                      fontSize: 15
                                  )
                              ),
                              leading: Icon(FontAwesomeIcons.search, color: AppColors.quaternaryText,),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
                          Card(
                            color: AppColors.quaternaryBackground,
                            child: ListTile(
                              title: const Text('Start Free Trial',
                                  style: const TextStyle(
                                    color: AppColors.primaryText,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )
                              ),
                              trailing: Switch(
                                value: switchValue,
                                onChanged: (value) {
                                  setState(() {
                                    switchValue = !switchValue;
                                  });
                                },
                                activeColor: AppColors.quaternaryText,
                                activeTrackColor: AppColors.primaryBackground,
                                inactiveThumbColor: AppColors.quaternaryText,
                                thumbColor: switchValue
                                    ? WidgetStateProperty.all(AppColors.quaternaryText)
                                    : WidgetStateProperty.all(AppColors.primaryBackground) ,
                                //inactiveTrackColor: AppColors.primaryBackground,
                              ),
                            ),
                          ),
                          Card(
                            color: AppColors.quaternaryBackground,
                            child: ListTile(
                              title: const Text('\$8.3 / month',
                                  style: TextStyle(
                                      color: AppColors.primaryText,
                                      fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )
                              ),
                              subtitle: const Text('About \$99 / year',
                                  style: TextStyle(
                                      color: AppColors.primaryText,
                                      fontSize: 15,
                                  ),
                              ),
                              trailing: Radio<String>(
                                value: options[0],
                                groupValue: currentOption,
                                splashRadius: 20,
                                onChanged: (value) {
                                  setState(() {
                                    currentOption = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                          Card(
                            color: AppColors.quaternaryBackground,
                            child: ListTile(
                              title: const Text('\$24.9 / month',
                                  style: const TextStyle(
                                    color: AppColors.primaryText,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )
                              ),
                              subtitle: Text('About \$299 / year',
                                  style: const TextStyle(
                                      color: AppColors.primaryText,
                                      fontSize: 15
                                  )
                              ),
                              trailing: Radio<String>(
                                value: options[1],
                                groupValue: currentOption,
                                splashRadius: 20,
                                onChanged: (value) {
                                  setState(() {
                                    currentOption = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: (){},
                      child: Text('SUBCRIBE NOW',
                          style: const TextStyle(
                            color:  AppColors.primaryText,
                            fontSize: 30,
                          )
                      ),
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all( AppColors.quaternaryText,),
                      ),
                    ),

                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}

