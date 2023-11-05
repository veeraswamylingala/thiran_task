import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:intl/intl.dart';
import 'package:task_thiran/Controllers/tickets_controller.dart';
import 'package:task_thiran/Services/db_helper.dart';

class TicketFormPage extends StatefulWidget {
  const TicketFormPage({super.key});

  @override
  State<TicketFormPage> createState() => _TicketFormPageState();
}

class _TicketFormPageState extends State<TicketFormPage> {
  DatabaseHelper dbHelper = DatabaseHelper();
  TicketController controller = Get.put(TicketController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _tTitle = TextEditingController();
  final TextEditingController _tLocation = TextEditingController();
  final TextEditingController _tDescription = TextEditingController();
  final TextEditingController _tDateTime = TextEditingController();
  String? _tAttachemntPath;

  @override
  void initState() {
    super.initState();
    _tDateTime.text = DateFormat('yyyy-MM-dd - HH:mm').format(DateTime.now());
  }

  @override
  void dispose() {
    super.dispose();
    _tTitle.dispose();
    _tDateTime.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(mainAxisSize: MainAxisSize.max, children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Required";
                      } else {
                        return null;
                      }
                    },
                    controller: _tTitle,
                    decoration: InputDecoration(
                      labelText: "Problem Title",
                      filled: true,
                      fillColor: Colors.grey.shade300,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Required";
                      } else {
                        return null;
                      }
                    },
                    controller: _tDescription,
                    decoration: InputDecoration(
                      labelText: "Problem Description",
                      filled: true,
                      fillColor: Colors.grey.shade300,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Required";
                      } else {
                        return null;
                      }
                    },
                    controller: _tLocation,
                    decoration: InputDecoration(
                      labelText: "Location",
                      filled: true,
                      fillColor: Colors.grey.shade300,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2)),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_tAttachemntPath != null)
                              SizedBox(
                                height: 200,
                                width: 200,
                                child: Image.network(
                                  _tAttachemntPath!,
                                ),
                              ),
                            Container(
                              child: IconButton(
                                  onPressed: () async {
                                    await controller
                                        .uploadAttachment(context: context)
                                        .then((value) {
                                      if (value != null) {
                                        print(value);
                                        setState(() {
                                          _tAttachemntPath = value;
                                        });
                                      }
                                    }).catchError((e) {
                                      print(e.toString());
                                    });
                                  },
                                  icon: const Icon(Icons.attach_file)),
                            )
                          ],
                        ),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _tDateTime,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Transcation Date&Time",
                      filled: true,
                      fillColor: Colors.grey.shade300,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Submit"),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          var ticketInfo = {
                            "ptDescription": _tDescription.text,
                            "tDate": _tDateTime.text,
                            "tLocation": _tLocation.text,
                            "tTitle": _tTitle.text,
                            "tAttachment": _tAttachemntPath
                          };
                          await controller.uploadStickerPack(
                              ticketInfo, _tTitle.text.toString());
                          Navigator.pop(context);
                        }
                      },
                    ),
                  )
                ]),
              )),
        ));
  }
}
