import 'package:flutter/material.dart';
import 'package:petition/Screens/AddUniversities.dart';
import 'package:petition/Screens/UpdateUniversities.dart';
import 'package:petition/Widgets/Drawer.dart';
import 'package:petition/models/ApiService.dart';

import '../Colors/Colors.dart';

class Universities extends StatefulWidget {
  const Universities({super.key});

  @override
  State<Universities> createState() => _UniversitiesState();
}

class _UniversitiesState extends State<Universities> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
      leading: InkWell(
          onTap: (){
            setState(() {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Universities(),));
            });
          },
          child: Icon(Icons.refresh_outlined)),
        centerTitle: true,
        foregroundColor: colors.helperWhiteColor,
        backgroundColor: colors.textFieldColor,
        title: Text('پوهنتونونه'),
      ),

     endDrawer: Drawer(child: DesignedDrawer(),),
      body: UniversitiesScreen(),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: colors.buttonColor,
        foregroundColor: colors.helperWhiteColor,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddUniversity(),
            ),
          );
        },
        label: Text('پوهنتون اضافه کړۍ'),
      ),
    );
  }
}





//actual screen
class UniversitiesScreen extends StatefulWidget {
  @override
  State<UniversitiesScreen> createState() => _UniversitiesScreenState();
}

_getUniversities()async{
  return await ApiService().fetchData('universities');
}


class _UniversitiesScreenState extends State<UniversitiesScreen> {
late Future _future;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   _future=_getUniversities();
  }
  @override
  Widget build(BuildContext context) {

    final currentWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: colors.backgroundColor,
      child: FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator.adaptive(),);
        }else if(snapshot.hasError){
          return Center(child: Icon(Icons.error_outline_outlined,color: colors.helperWhiteColor,),);
        }else if(snapshot.hasData) {
          return GridView.builder(
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.all(30),
            itemCount: snapshot.data.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: currentWidth > 500 ? 4 : 1),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {

                  UpdateUniversity(context,snapshot.data[index]);
                },
                child: Card(
                  child: ListTile(
                    textColor: colors.helperWhiteColor,
                    tileColor: colors.textFieldColor,
                    title: Text(
                      snapshot.data[index]['name'],
                      textAlign: TextAlign.right,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Icon(
                            Icons.school_outlined,
                            color: colors.helperWhiteColor,
                            size: 150,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }else {
          return Center(child: Text('معلومات پیدا نشول'),);
        }
      },
      ),
    );
  }
}
