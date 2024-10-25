
import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:flutter/material.dart';

class EmailReplyView extends StatelessWidget {
  final List<String> promptLanguage = ['English', 'Vietnamese', 'Japanese', 'India'];

  static const TextStyle inputHeaderTextStyle = TextStyle(
    color: AppColors.quaternaryText,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackground,
        title: const Text('Email Reply',
            style: TextStyle(
                color: AppColors.quaternaryText,
                fontSize: 30,
            ),
            
        ),
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
                        Navigator.pop(context);
                        Navigator.pop(context);
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
                      leading: const Icon(Icons.chat_rounded),
                      title: const Text('Chat'),
                      
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/main');
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
                      
                        //Navigator.pop(context);
                        //Navigator.pushNamed(context, '/email-reply');
                      },
                    ),
                  ),
                ],
              ),
            ),
            
      body: Container(
        color: AppColors.primaryBackground,
        child: SingleChildScrollView(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          children: <Widget>[
                            Container(
                                margin: const EdgeInsets.only(top: 5, left: 5, right: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text('Original Text',
                                      style: inputHeaderTextStyle,
                                    ),
                                    TextField(
                                      minLines: 5,
                                      maxLines: null,
                                      textCapitalization: TextCapitalization.sentences,
                                      keyboardType: TextInputType.multiline,
                                      style: const TextStyle(
                                        color: AppColors.quaternaryText,
                                      ),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: AppColors.primaryBackground,
                                        hintText: 'Enter Prompt Name',
                                        contentPadding: const EdgeInsets.all(10),
                                        hintStyle: const TextStyle(
                                          color: AppColors.greyText,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: AppColors.secondaryBackground,
                                            width: 4.0,
                                          ),
                                        ),
                                      ),
                                      onSubmitted: (value) {

                                      },
                                    ),
                                  ],
                                )
                            ),
                            Container(
                                margin: const EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text('Actions',
                                      style: inputHeaderTextStyle,
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Wrap(
                                        alignment: WrapAlignment.start,
                                        spacing: 10,
                                        runSpacing: 10,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {},
                                            child: const Text('Thanks'),
                                            style: ButtonStyle(
                                              backgroundColor: WidgetStateProperty.all(AppColors.quaternaryBackground),
                                              foregroundColor: WidgetStateProperty.all(AppColors.primaryText),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {},
                                            style: ButtonStyle(
                                              backgroundColor: WidgetStateProperty.all(AppColors.quaternaryBackground),
                                              foregroundColor: WidgetStateProperty.all(AppColors.primaryText),
                                            ),
                                            child: const Text('Sorry'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {},
                                            child: const Text('Yes'),
                                            style: ButtonStyle(
                                              backgroundColor: WidgetStateProperty.all(AppColors.quaternaryBackground),
                                              foregroundColor: WidgetStateProperty.all(AppColors.primaryText),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {},
                                            child: const Text('Follow Up'),
                                            style: ButtonStyle(
                                              backgroundColor: WidgetStateProperty.all(AppColors.quaternaryBackground),
                                              foregroundColor: WidgetStateProperty.all(AppColors.primaryText),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {},
                                            child: const Text('No'),
                                            style: ButtonStyle(
                                              backgroundColor: WidgetStateProperty.all(AppColors.quaternaryBackground),
                                              foregroundColor: WidgetStateProperty.all(AppColors.primaryText),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {},
                                            child: const Text('Request for More Information'),
                                            style: ButtonStyle(
                                              backgroundColor: WidgetStateProperty.all(AppColors.quaternaryBackground),
                                              foregroundColor: WidgetStateProperty.all(AppColors.primaryText),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ],
                                )
                            ),
                            Container(
                                margin: const EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text('Length',
                                      style: inputHeaderTextStyle,
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Wrap(
                                        alignment: WrapAlignment.start,
                                        spacing: 10,
                                        runSpacing: 10,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {},
                                            child: const Text('Auto'),
                                            style: ButtonStyle(
                                              backgroundColor: WidgetStateProperty.all(AppColors.quaternaryBackground),
                                              foregroundColor: WidgetStateProperty.all(AppColors.primaryText),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {},
                                            child: const Text('Short'),
                                            style: ButtonStyle(
                                              backgroundColor: WidgetStateProperty.all(AppColors.quaternaryBackground),
                                              foregroundColor: WidgetStateProperty.all(AppColors.primaryText),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {},
                                            child: const Text('Medium'),
                                            style: ButtonStyle(
                                              backgroundColor: WidgetStateProperty.all(AppColors.quaternaryBackground),
                                              foregroundColor: WidgetStateProperty.all(AppColors.primaryText),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {},
                                            child: const Text('Long'),
                                            style: ButtonStyle(
                                              backgroundColor: WidgetStateProperty.all(AppColors.quaternaryBackground),
                                              foregroundColor: WidgetStateProperty.all(AppColors.primaryText),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                            ),
                            Container(
                                margin: const EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text('Output Language',
                                      style: inputHeaderTextStyle,
                                    ),
                                    ListTile(
                                      title: Container(
                                        alignment: Alignment.centerLeft,
                                        margin: const EdgeInsets.only(bottom: 5),
                                        padding: const EdgeInsets.only(left: 10, right: 10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: AppColors.quaternaryBackground,
                                        ),
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          value: promptLanguage[0],
                                          icon: const Icon(Icons.arrow_drop_down),
                                          iconSize: 24,
                                          elevation: 16,
                                          style: const TextStyle(color: AppColors.primaryText),
                                          underline: Container(
                                            height: 2,
                                            color: AppColors.quaternaryBackground,
                                          ),
                                          onChanged: (String? newValue) {
                                            // setState(() {
                                            //   dropdownValue = newValue!;
                                            // });
                                          },
                                          items: promptLanguage
                                              .map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              margin: const EdgeInsets.all(5),
                              child: ElevatedButton(
                                onPressed: () {},
                                child: const Text('Generate'),
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(AppColors.secondaryBackground),
                                  foregroundColor: WidgetStateProperty.all(AppColors.quaternaryText),
                                ),
                              ),
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          const Text('Preview',
                                            style: inputHeaderTextStyle,
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.arrow_back_ios,
                                              color: AppColors.quaternaryText,
                                            ),
                                            onPressed: () {},
                                          ),
                                          Text('1/3',
                                            style: const TextStyle(
                                              color: AppColors.quaternaryText,
                                              fontSize: 15,
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.arrow_forward_ios,
                                              color: AppColors.quaternaryText,
                                            ),
                                            onPressed: () {},
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          IconButton(
                                            icon: const Icon(Icons.contactless,
                                              color: AppColors.quaternaryText,
                                            ),
                                            onPressed: () {},
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.refresh,
                                              color: AppColors.quaternaryText,
                                            ),
                                            onPressed: () {},
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  TextField(
                                    enabled: false,
                                    minLines: 5,
                                    maxLines: 10,
                                    textCapitalization: TextCapitalization.sentences,
                                    keyboardType: TextInputType.multiline,
                                    style: const TextStyle(
                                      color: AppColors.quaternaryText,
                                    ),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: AppColors.primaryBackground,
                                      hintText: 'I can\'t answer your question right now. I will get back to you soon. Thank you for your patience.',
                                      contentPadding: const EdgeInsets.all(5),
                                      hintStyle: const TextStyle(
                                        color: AppColors.greyText,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: AppColors.secondaryBackground,
                                          width: 4.0,
                                        ),
                                      ),
                                    ),
                                    onSubmitted: (value) {

                                    },
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              margin: const EdgeInsets.all(5),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(AppColors.secondaryBackground),
                                  foregroundColor: WidgetStateProperty.all(AppColors.quaternaryText),
                                ),
                                child: const Text('Copy'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
        ),
      ),

    );
  }
}

