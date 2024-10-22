import 'package:chatbot_agents/screens/profile/profile_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/app_colors.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  TabBar get _tabBar => const TabBar(
    indicatorColor: AppColors.quaternaryText,
    dividerColor: AppColors.quaternaryText,
    labelColor: AppColors.quaternaryText,
    unselectedLabelColor: Colors.white,
    tabs: [
      Tab(
        icon: Icon(Icons.chat_rounded),
        text: "Chat",
      ),
      Tab(
        icon: Icon(FontAwesomeIcons.robot),
        text: "AI Bot",
      ),
      Tab(
        icon: Icon(Icons.menu_book),
        text: "Knowledge",
      ),
      Tab(
          icon: Icon(FontAwesomeIcons.penNib),
          text: "Prompt"
      ),
      Tab(
          icon: Icon(FontAwesomeIcons.solidUserCircle),
          text: "Profile"
      ),
    ],
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: DefaultTabController(
          length: 5,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.secondaryBackground,
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(Icons.menu,
                      color: AppColors.quaternaryText,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications,
                    color: AppColors.quaternaryText,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.settings,
                    color: AppColors.quaternaryText,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            drawer: Drawer(
              child: ListView(
                padding: const EdgeInsets.all(0),
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Text('AI Assistant'),
                  ),
                  ListTile(
                    title: const Text('Tokens'),
                    trailing: Text('30/50'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text('Email Reply'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),

                ],
              ),
            ),
            body: TabBarView(
              children: [
                ProfileView(),
                ProfileView(),
                ProfileView(),
                Icon(FontAwesomeIcons.penNib),
                Icon(FontAwesomeIcons.solidUserCircle),
              ],
            ),
            bottomNavigationBar: PreferredSize(
                preferredSize: _tabBar.preferredSize,
                child: ColoredBox(
                  color: AppColors.secondaryBackground,
                  child: _tabBar,
                ),
            ),
          ),
        ),
    );
  }
}