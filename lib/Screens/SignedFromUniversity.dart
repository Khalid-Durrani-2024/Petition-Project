import 'package:flutter/material.dart';
import '../Widgets/Drawer.dart';
import '../Widgets/Message.dart';
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
            if (element['university_id'] == User['university_id']) {
              naturalData.add(Petitionelement);
            }
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
                                children: [
                                  Text(
                                    snapshot.data[index]['sender'],
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Colors
                                          .black, // Adjust to your light color theme
                                    ),
                                  ),
                                  Text(
                                    snapshot.data[index]['title'],
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Colors
                                          .black, // Adjust to your light color theme
                                    ),
                                  ),
                                  Text(
                                    snapshot.data[index]['date'],
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Colors
                                          .black, // Adjust to your light color theme
                                    ),
                                  ),
                                  Text(
                                    snapshot.data[index]['receiver'],
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Colors
                                          .black, // Adjust to your light color theme
                                    ),
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
                  InkWell(
                    child: Icon(Icons.arrow_forward_ios_rounded),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    "نمبر مکتوب: " + snapshot['id'].toString(),
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  Text(
                    "تاریخ: " + snapshot['date'],
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  Text(
                    'موضوع: ${snapshot['title']} ',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    snapshot['description'],
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //erased till description
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
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(snapshot.data?['comment']),
                            Text(
                              ' :پوهنځي نظر',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        );
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
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(snapshot.data?['comment']),
                            Text(
                              ' :پوهنتون نظر',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Icon(Icons.error_outline_outlined);
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
                              user_id: User['id'].toString(),
                              signed_at:
                                  DateTime.now().toString().substring(0, 10),
                              petition_id: snapshot['id'].toString(),
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
