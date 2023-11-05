import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:task_thiran/Models/transcation_model.dart';
import 'package:task_thiran/Services/db_helper.dart';
import 'package:task_thiran/Views/widget_helper.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  DatabaseHelper dbHelper = DatabaseHelper();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _tDescription = TextEditingController();
  final TextEditingController _tDateTime = TextEditingController();
  String? _tStaus;

  @override
  void initState() {
    super.initState();
    _tDateTime.text = DateFormat('yyyy-MM-dd - HH:mm').format(DateTime.now());
  }

  @override
  void dispose() {
    super.dispose();
    _tDescription.dispose();
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
              child: Column(mainAxisSize: MainAxisSize.max, children: [
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
                    labelText: "Transcation Description",
                    filled: true,
                    fillColor: Colors.grey.shade300,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                DropdownButtonFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Required";
                      } else {
                        return null;
                      }
                    },
                    value: _tStaus,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade300,
                    ),
                    hint: const Text("Transaction Status"),
                    iconSize: 30.0,
                    items: ['Success', 'Pending', 'Error'].map(
                      (val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      setState(() {
                        _tStaus = val;
                      });
                    }),
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
                        Transaction transcaion = Transaction(
                            tDescription: _tDescription.text,
                            tDateTime: _tDateTime.text,
                            tStatus: _tStaus!);
                        //send mail then store into DB--------------
                        // await sendEmail().then((value) async {
                        //   if (value) {
                        //inserting into db------------------
                        await dbHelper
                            .insert(transcaion.mapTransaction())
                            .then((value) {
                          showToast(
                              message: "Successfull Record Submission!",
                              context: context);
                          Navigator.pop(context, true);
                        }).catchError((e) {
                          print(e.toString());
                        });
                        // } else {
                        //   //show toast Message---------
                        //   showToast(
                        //       message: "Error in Sending Mail try again!",
                        //       context: context);
                        // }
                        //});
                      }
                    },
                  ),
                )
              ])),
        ));
  }

  Future<bool> sendEmail() async {
    String username = 'username@gmail.com';
    String password = 'password';

    final smtpServer = gmail(username, password);
    // Create our message.
    final message = Message()
      ..from = Address(username, 'Your name')
      ..recipients.add('destination@example.com')
      ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
      ..bccRecipients.add(const Address('bccAddress@example.com'))
      ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: $sendReport');
      return true;
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
      return false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
