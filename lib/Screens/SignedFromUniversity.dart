import 'package:flutter/material.dart';
import 'package:petition/Widgets/Drawer.dart';
import 'package:petition/Widgets/Message.dart';

import '../models/ApiService.dart';
import '../models/SignPetitionModel.dart';
import 'Maktob.dart';

class SignedFromUniversity extends StatefulWidget {
  const SignedFromUniversity({super.key});

  @override
  State<SignedFromUniversity> createState() => _SignedFromUniversityState();
}

class _SignedFromUniversityState extends State<SignedFromUniversity> {
  @override
  late Future getSignedPetition;

  _getSignedPetitions() async {
    List naturalData = [];
    try {
      List signed = await ApiService().fetchData('send_from_faculty');
      List petitions = await ApiService().fetchData('petitions');
      petitions.forEach((Petitionelement) {
        signed.forEach((element) {
          if (Petitionelement['id'] == element['petition_id']) {
            naturalData.add(Petitionelement);
          }
        });
      });
    } catch (e) {
      print(e);
    }
    return naturalData;
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getSignedPetition = _getSignedPetitions();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      endDrawer: Drawer(
        child: DrawerForUniversity(),
      ),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 15, 31, 253),
        centerTitle: true,
        title: Text('د اسنادو د لیږد را لیږد مدیریتی سیستم'),
      ),
      backgroundColor: Color.fromARGB(255, 246, 246, 246),
      body: Container(
          color: Colors.white38,
          child: Container(
            padding: EdgeInsets.all(20),
            child: FutureBuilder(
              future: getSignedPetition,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Icon(
                      Icons.error_outline_outlined,
                      color: Colors.red,
                    ),
                  );
                } else if (snapshot.hasData) {
                  return Scrollbar(
                    child: GridView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: width > 300 ? 3 : 1,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1.5),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            showMaktobBeforeSendingToMinistry(
                              context,
                              snapshot.data[index],
                            );
                          },
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color.fromARGB(255, 167, 229,
                                    255), // Adjust to your light color theme
                              ),
                              padding: EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    snapshot.data[index]['date'],
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors
                                          .black, // Adjust to your light color theme
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    snapshot.data[index]['description'],
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors
                                          .black, // Adjust to your light color theme
                                    ),
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: Text('معلومات پیدا نشول'),
                  );
                }
              },
            ),
          )),
    );
  }
}

//showing Maktob Before Sending to Ministry
showMaktobBeforeSendingToMinistry(BuildContext context, Map snapshot) {
  String? res;
  getSignedData() async {
    try {
      List data = await ApiService().fetchData('send_from_faculty');
      Map fResponse = {};
      data.forEach((element) {
        if (snapshot['id'] == element['petition_id']) {
          fResponse = element;
        }
      });
      return fResponse;
    } catch (e) {
      print(e);
    }
  }

  getUResponseData() async {
    try {
      List data = await ApiService().fetchData('received_to_faculties');
      Map fResponse = {};
      data.forEach((element) {
        if (snapshot['id'] == element['petition_id']) {
          fResponse = element;
        }
      });
      return fResponse;
    } catch (e) {
      print(e);
    }
  }

  {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 249, 230, 230),
          content: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.blue,
                          ))
                    ],
                  ),
                  Text(
                    "نمبر مکتوب: " + snapshot['id'],
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  Text(
                    "تاریخ: " + snapshot['date'],
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  Text(
                    snapshot['sender'] + " :لیږوونکی",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    snapshot['description'],
                    style: TextStyle(color: Colors.black),
                  ),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  FutureBuilder(
                    future: getSignedData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasData) {
                        res = snapshot.data?['comment'];
                        return Text('${snapshot.data?['comment']} :پوهنځي نظر');
                      } else {
                        return Text('معلومات لوډ نشول');
                      }
                    },
                  ),
                  FutureBuilder(
                    future: getUResponseData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasData) {
                        var temp = res;
                        res = ' پوهنځی نظر ' +
                            snapshot.data?['comment'] +
                            ' پوهنتون نظر ' +
                            temp!;
                        return Text(
                            '${snapshot.data?['comment']} :پوهنتون نظر');
                      } else {
                        return Text('معلومات لوډ نشول');
                      }
                    },
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Center(
                    child: TextButton(
                        onPressed: () async {
                          final signPetition = SignPetitionModel(
                              user_id: User['id'],
                              signed_at:
                                  DateTime.now().toString().substring(0, 10),
                              petition_id: snapshot['id'],
                              comment: res.toString());

                          int signResponseCode = await ApiService()
                              .signPetition(signPetition, 'signatures');
                          Navigator.pop(context);
                          if (signResponseCode == 201) {
                            Message(
                                true, context, 'وزارت ته مکتوب ځواب واستول شو');
                          } else {
                            Message(false, context, 'ستونزه ده');
                          }
                        },
                        child: Text('بــــــیرته ولیږۍ وزارت ته')),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
