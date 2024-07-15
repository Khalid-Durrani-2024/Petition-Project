import 'package:flutter/material.dart';
import 'package:petition/Widgets/Drawer.dart';
import '../models/ApiService.dart';
import '../Colors/Colors.dart';


class SignedPetitions extends StatelessWidget {
  const SignedPetitions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('امضاء شوي مکتوبونه'),
        centerTitle: true,
        backgroundColor: colors.textFieldColor,
        foregroundColor: colors.helperWhiteColor,
      ),
      body: Signed(),
  endDrawer: Drawer(

    child: DesignedDrawer(),
  ),
    );
  }
}

//actual screen

class Signed extends StatefulWidget {
  const Signed({super.key});

  @override
  State<Signed> createState() => _SignedState();
}

class _SignedState extends State<Signed> {
  late Future getSignedPetition;
  _getSignedPetitions()async{
    List naturalData=[];
   List signed= await ApiService().fetchData('signatures');
   List petitions=await ApiService().fetchData('petitions');

   petitions.forEach((Petitionelement) {
     signed.forEach((element) {
       if(Petitionelement['id']==element['petition_id']){
         naturalData.add(Petitionelement);

       }
     });
   });
  return naturalData;
  }



@override
  void initState() {
    // TODO: implement initState
    super.initState();
   getSignedPetition= _getSignedPetitions();

  }


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      color: colors.backgroundColor,
      width: width,
      height: height,
      child: FutureBuilder(
        future: getSignedPetition,
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child:CircularProgressIndicator());
          }else if(snapshot.hasError){
            return Center(child: Icon(Icons.error_outline_outlined,color: Colors.red,),);
          }else if(snapshot.hasData){

                return     GridView.builder(
                  physics: BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(30),
                  itemCount: snapshot.data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: width > 500 ? 4 : 1),
                  itemBuilder: (context, index) {

                    return InkWell(
                      onTap: () {
                        _resend(context, snapshot.data[index]);
                      },
                      child: Card(
                        child: ListTile(
                          textColor: colors.helperWhiteColor,
                          tileColor: colors.textFieldColor,
                          title: Text(
                            snapshot.data[index]['date'],
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 20),
                          ),
                          subtitle: Text(
                            snapshot.data[index]['description'],
                            textAlign: TextAlign.right,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ),
                    );
                  },
                );

        }else {
          return  Center(child: Text('معلومات پیدا نشول'),);
          }
        },
      ),
    );
  }
}

//show dialog on resending

_resend(BuildContext context, Map data) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: colors.backgroundColor,
        title: Text(
          data['title'],
          style: TextStyle(color: colors.helperWhiteColor),
          textAlign: TextAlign.center,
        ),
        content: Text(
          data['description'],
          style: TextStyle(color: colors.helperWhiteColor),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        actions: [
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(colors.buttonColor),
            ),
            onPressed: () {
              print('Resend Ptitioon button');
              Navigator.pop(context);
            },
            child: Icon(
              Icons.done,
              color: colors.helperWhiteColor,
            ),
          ),
        ],
      );
    },


    
  );
}
