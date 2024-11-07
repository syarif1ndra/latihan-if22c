import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/mahasiswa_controller.dart';

class MahasiswaView extends GetView<MahasiswaController> {
  const MahasiswaView({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3640279626.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:674613771.
      stream: Get.put(MahasiswaController()).StreamData(),
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1163962038.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2987803429.
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          var listAllDocs = snapshot.data?.docs ?? [];
          return listAllDocs.length > 0
              ? ListView.builder(
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3133421910.
                  itemCount: listAllDocs.length,
                  itemBuilder: (context, index) => ListTile(
                        leading: CircleAvatar(
                          child: Text('${index + 1}'),
                          backgroundColor:
                              const Color.fromARGB(255, 245, 21, 223),
                        ),
                        title: Text(
                            "${(listAllDocs[index].data() as Map<String, dynamic>)["nama"]}"),
                        subtitle: Text(
                            "${(listAllDocs[index].data() as Map<String, dynamic>)["npm"]}"),
                        trailing: IconButton(
                          onPressed:(){},
                         icon: Icon(Icons.ad_units),
                         color: const Color.fromARGB(255, 255, 0, 183),
                         )
                      ))
              : Center(
                  child: Text('Data Kosong'),
                );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
