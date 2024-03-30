import 'package:finalprojectbarber/widgets/admin_tile.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../data_manager/data_manager.dart';



class adminSearchingScreen extends StatelessWidget {
  const adminSearchingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Consumer<DataManagerProvider>(
            builder: (context, data, child){
              if(data.searchListAdmins.isNotEmpty){
                return Column(
                    children: data.getSearchListadmin.map((x) {
                   return adminTile(x , context);
                    }).toList());
              }
              else{
                return const Align(
                    alignment: Alignment.topCenter,
                    child: Text('ไม่พบข้อมูล'));
              }

            },
          ),
        ]
      )
    );
  }
}
