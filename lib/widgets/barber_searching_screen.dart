import 'package:finalprojectbarber/widgets/barber_tile.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../data_manager/data_manager.dart';



class barberSearchingScreen extends StatelessWidget {
  const barberSearchingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Consumer<DataManagerProvider>(
            builder: (context, data, child){
              if(data.searchListBarbers.isNotEmpty){
                return Column(
                    children: data.getSearchListbarber.map((x) {
                   return barberTile(x , context);
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
