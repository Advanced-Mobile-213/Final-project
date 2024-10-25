import 'package:chatbot_agents/views/ai_bot/ai_bot_view.dart';
import 'package:chatbot_agents/views/ai_bot/chat_history_view.dart';
import 'package:chatbot_agents/views/knowledge/knowledge.dart';
import 'package:chatbot_agents/views/profile/profile_view.dart';
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
          Tab(icon: Icon(FontAwesomeIcons.penNib), text: "Prompt"),
          Tab(icon: Icon(FontAwesomeIcons.solidUserCircle), text: "Profile"),
        ],
      );

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    int selectedTab = arguments != null ? arguments!['selectedTab'] : 0;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: DefaultTabController(
        length: 5,
        initialIndex: selectedTab,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.secondaryBackground,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(
                    Icons.menu,
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
                icon: const Icon(
                  Icons.notifications,
                  color: AppColors.quaternaryText,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  Icons.settings,
                  color: AppColors.quaternaryText,
                ),
                onPressed: () {},
              ),
            ],
          ),
          drawer: Drawer(
            backgroundColor: AppColors.primaryBackground,
            child: ListView(
              padding: const EdgeInsets.only(top: 20),
              children: [
                Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    tileColor: AppColors.secondaryBackground,
                    style: ListTileStyle.drawer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textColor: AppColors.quaternaryText,
                    iconColor: AppColors.quaternaryText,
                    leading: const Icon(Icons.local_fire_department),
                    title: const Text('Tokens'),
                    trailing: Text('30/50'),
                    onTap: () {
                      //Navigator.pop(context);
                    },
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    tileColor: AppColors.secondaryBackground,
                    style: ListTileStyle.drawer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textColor: AppColors.quaternaryText,
                    iconColor: AppColors.quaternaryText,
                    leading: const Icon(Icons.email),
                    title: const Text('Email Reply'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ChatHistoryView(),
              AIBotView(),
              KnowledgeListView(),  
              Icon(FontAwesomeIcons.solidUserCircle),
              ProfileView(),
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
