import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_thiran/Controllers/tickets_controller.dart';
import 'package:task_thiran/Services/db_helper.dart';

import 'ticket_form_page.dart';

class TicketsListpage extends StatefulWidget {
  const TicketsListpage({super.key});

  @override
  State<TicketsListpage> createState() => _TicketsListpageState();
}

class _TicketsListpageState extends State<TicketsListpage> {
  DatabaseHelper dbHelper = DatabaseHelper();
  TicketController controller = Get.put(TicketController());
  var showPackStickers = [];
  late int lengthOfStickerPacks = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Tickets"),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 10.0,
          onPressed: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TicketFormPage()))
                .then((value) {
              setState(() {});
            });
          },
          child: const Icon(Icons.add),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: controller.fetchTicketsStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                lengthOfStickerPacks = snapshot.data!.docs.length;

                print(snapshot.data!.docs.length);
                return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, i) {
                      Map<String, dynamic> data = snapshot.data!.docs[i].data()!
                          as Map<String, dynamic>;

                      return Card(
                        child: ListTile(
                          onTap: () {
                            // setState(() {
                            //   showPackStickers = data['stickers'];
                            // });
                          },
                          leading: const Icon(Icons.assessment),
                          title: Text(data['tTitle']),
                          subtitle: Text(data['ptDescription']),
                          trailing: data['tAttachment'] != null
                              ? Image.network(data['tAttachment'])
                              : const SizedBox(),
                        ),
                      );
                    });
              }
            }));
  }
}
