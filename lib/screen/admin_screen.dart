import 'package:finalprojectbarber/php_data/php_data.dart';
import 'package:finalprojectbarber/screen/admin_add_details_screen.dart';
import 'package:finalprojectbarber/theme/extention.dart';
import 'package:finalprojectbarber/widgets/admin_searching_screen.dart';
import 'package:finalprojectbarber/widgets/dashboard/admin_list_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data_manager/data_manager.dart';
import '../theme/light_color.dart';
import '../theme/text_styles.dart';

import '../widgets/admin_header.dart';

class AdminPage extends StatefulWidget {
  AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  bool searchingStart = false;
  TextEditingController textController = TextEditingController();
  @override
  void initState() {
    super.initState();
    textController.addListener(() {
      if (textController.text.isNotEmpty) {
        Provider.of<DataManagerProvider>(context, listen: false)
            .searchListAdmins
            .clear();
        Provider.of<DataManagerProvider>(context, listen: false)
            .setIsSearching(true);
        Provider.of<DataManagerProvider>(context, listen: false)
            .getSearchAdmin(textController.text);
      } else {
        Provider.of<DataManagerProvider>(context, listen: false)
            .setIsSearching(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    getAllAdmins(context);
    return Scaffold(
      body: Consumer<DataManagerProvider>(
        builder: (context, providerData, child) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const AdminHeader(),
                    Container(
                      height: 55,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(13)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: LightColor.grey.withOpacity(.8),
                            blurRadius: 15,
                            offset: const Offset(5, 5),
                          )
                        ],
                      ),
                      child: TextField(
                        controller: textController,
                        onChanged: (value) {
                          print(value);
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          border: InputBorder.none,
                          hintText: "Search...",
                          hintStyle: TextStyles.body.subTitleColor,
                          suffixIcon: SizedBox(
                            width: 50,
                            child: const Icon(Icons.search, color: LightColor.purple)
                                .alignCenter
                                .ripple(
                                  () {},
                                  borderRadius: BorderRadius.circular(13),
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Provider.of<DataManagerProvider>(context).searchingStart
                  ? const adminSearchingScreen()
                  : AdminList(providerData.getAllAdmin, context),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AdminAddDetailScreen()),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
