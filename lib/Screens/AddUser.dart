import 'package:flutter/material.dart';
import 'package:petition/models/ApiService.dart';

import '../Colors/Colors.dart';

class AddUser extends StatelessWidget {
  const AddUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(onPressed: (){}, label: Text('اډمین اضافه کړۍ'),),
      body: AddUserScreen(),
      appBar: AppBar(
        foregroundColor: colors.helperWhiteColor,
        backgroundColor: colors.textFieldColor,
        title: Text('د پوهنتونونو اډمینان'),
        centerTitle: true,
      ),
    );
  }
}

//adding new user to the system using admin
class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    _getUsers() async {
      return await ApiService().fetchData('users');
    }

    var _currentWidt = MediaQuery.of(context).size.width;
    return Container(
        color: colors.backgroundColor,
        width: double.infinity,
        height: double.infinity,
        child: FutureBuilder(
          future: _getUsers(),
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
              return GridView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      tileColor: colors.textFieldColor,
                      textColor: colors.helperWhiteColor,
                      title: Text(
                        '${snapshot.data[index]['name']} :نوم',
                        style:
                            TextStyle(fontSize: _currentWidt > 500 ? 20 : 36),
                      ),
                      subtitle: Text(
                        '${snapshot.data[index]['email']} :ایمیل ',
                        style:
                            TextStyle(fontSize: _currentWidt > 500 ? 18 : 36),
                      ),
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _currentWidt > 500 ? 4 : 1),
              );
            } else {
              return Center(
                child: Text(
                  'معلومات نشته',
                  style: TextStyle(color: colors.helperWhiteColor),
                ),
              );
            }
          },
        ));
  }
}

//
// Form(
// key: _formKey,
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Container(
// //User ID Field
// decoration: BoxDecoration(
// color: colors.textFieldColor,
// borderRadius: BorderRadius.circular(22)),
// width: width / 2,
// child: TextFormField(
// textDirection: TextDirection.rtl,
// enabled: false,
// initialValue: '۶',
// validator: (value) {},
// keyboardType: TextInputType.emailAddress,
// style: const TextStyle(color: Colors.white),
// decoration: InputDecoration(
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(22)),
// labelStyle: const TextStyle(
// color: Colors.white,
// fontSize: 12,
// fontWeight: FontWeight.w100),
// label: const Text(' مسلسله شمیره'),
// ),
// ),
// ),
// SizedBox(
// height: height / 30,
// ),
// Container(
// decoration: BoxDecoration(
// color: colors.textFieldColor,
// borderRadius: BorderRadius.circular(22)),
// width: width / 2,
// child: TextFormField(
// textDirection: TextDirection.rtl,
// validator: (value) {
// if (value!.isEmpty) {
// return 'د استعمالوونکي پوره نوم ولیکۍ';
// }
// return null;
// },
// keyboardType: TextInputType.emailAddress,
// style: const TextStyle(color: Colors.white),
// decoration: InputDecoration(
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(22)),
// labelStyle: const TextStyle(
// color: Colors.white,
// fontSize: 12,
// fontWeight: FontWeight.w100),
// label: const Text('نوم')),
// ),
// ),
// SizedBox(
// height: height / 30,
// ),
// Container(
// decoration: BoxDecoration(
// color: colors.textFieldColor,
// borderRadius: BorderRadius.circular(22)),
// width: width / 2,
// child: TextFormField(
// textDirection: TextDirection.rtl,
// validator: (value) {
// if (value!.isEmpty) {
// return 'د استعمالوونکۍ ایمیل ادرس ولیکۍ';
// }
// return null;
// },
// keyboardType: TextInputType.emailAddress,
// style: const TextStyle(color: Colors.white),
// decoration: InputDecoration(
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(22)),
// labelStyle: const TextStyle(
// color: Colors.white,
// fontSize: 12,
// fontWeight: FontWeight.w100),
// label: const Text('ایمیل')),
// ),
// ),
// SizedBox(
// height: height / 30,
// ),
// Container(
// decoration: BoxDecoration(
// color: colors.textFieldColor,
// borderRadius: BorderRadius.circular(22)),
// width: width / 2,
// child: TextFormField(
// textDirection: TextDirection.rtl,
// obscureText: true,
// validator: (value) {
// if (value!.isEmpty) {
// return 'د استعمالوونکي لپاره پټ نوم انتخاب کړۍ';
// }
// return null;
// },
// keyboardType: TextInputType.emailAddress,
// style: const TextStyle(color: Colors.white),
// decoration: InputDecoration(
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(22)),
// labelStyle: const TextStyle(
// color: Colors.white,
// fontSize: 12,
// fontWeight: FontWeight.w100),
// label: const Text('پټ نوم')),
// ),
// ),
// SizedBox(
// height: height / 30,
// ),
// Container(
// decoration: BoxDecoration(
// color: colors.textFieldColor,
// borderRadius: BorderRadius.circular(22)),
// width: width / 2,
// child: DropdownMenu(
// enableSearch: true,
// width: MediaQuery.of(context).size.width / 4,
// menuStyle: MenuStyle(
// backgroundColor:
// MaterialStatePropertyAll(colors.buttonColor)),
// leadingIcon: Icon(
// Icons.school_outlined,
// color: colors.helperWhiteColor,
// ),
// textStyle: TextStyle(color: colors.helperWhiteColor),
// label: Text(
// 'انتخاب کړۍ',
// style: TextStyle(color: colors.helperWhiteColor),
// ),
// dropdownMenuEntries: [
// DropdownMenuEntry(
// style: ButtonStyle(
// foregroundColor:
// MaterialStatePropertyAll(colors.helperWhiteColor),
// ),
// value: Text('University selection'),
// label: 'کابل پوهنتون'),
// DropdownMenuEntry(
// style: ButtonStyle(
// foregroundColor:
// MaterialStatePropertyAll(colors.helperWhiteColor),
// ),
// value: Text('University selection'),
// label: 'ننګرهار پوهنتون'),
// DropdownMenuEntry(
// style: ButtonStyle(
// foregroundColor:
// MaterialStatePropertyAll(colors.helperWhiteColor),
// ),
// value: Text('University selection'),
// label: 'کنړ پوهنتون'),
// ],
// ),
// ),
// SizedBox(
// height: height / 30,
// ),
// InkWell(
// onTap: () {
// if (_formKey.currentState!.validate()) {
// showMessage(false, context);
// }
// },
// //Save Button
// child: Container(
// alignment: Alignment.center,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(22),
// color: colors.buttonColor),
// width: width / 5,
// height: height / 15,
// child: const Text(
// 'ثبت کړۍ',
// style: TextStyle(
// color: Colors.white,
// fontWeight: FontWeight.bold,
// fontSize: 18),
// ),
// ),
// ),
// ],
// )),
//Message Showing Success and not success

showMessage(bool isSuccess, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog.adaptive(
        backgroundColor: colors.backgroundColor,
        actions: [
          InkWell(
            child: Icon(
              Icons.close_outlined,
              color: colors.helperWhiteColor,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
        title: Icon(
          isSuccess == true ? Icons.check : Icons.dangerous_outlined,
          color: isSuccess == true ? Colors.green : Colors.red,
          size: 60,
        ),
        content: isSuccess == true
            ? Text('نوی استعمالوونکی سیستم ته اضافه شو')
            : Text('ستونزه رامنځته شوه'),
        contentTextStyle: TextStyle(color: colors.helperWhiteColor),
      );
    },
  );
}
