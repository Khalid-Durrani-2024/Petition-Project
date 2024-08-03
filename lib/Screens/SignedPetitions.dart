import 'package:flutter/material.dart';
import '../Widgets/Drawer.dart';
import '../models/ApiService.dart';



class SignedPetitions extends StatelessWidget {
  const SignedPetitions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 15, 31, 253),
        centerTitle: true,
        title: Text('د اسنادو د لیږد را لیږد مدیریتی سیستم'),

      ),
      backgroundColor:
      Color.fromARGB(255, 246, 246, 246),
      body: Container(
          color: Colors.white38,
          child: Signed()),

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
      padding: EdgeInsets.all(20),
      child: FutureBuilder(
        future: getSignedPetition,
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child:CircularProgressIndicator());
          }else if(snapshot.hasError){
            return Center(child: Icon(Icons.error_outline_outlined,color: Colors.red,),);
          }else if(snapshot.hasData){

                return    GridView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: width > 300 ? 3 : 1,
                  crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.5
                  ),

                  itemBuilder: (context, index) {

                    return InkWell(
                      onTap: () {
                        _resend(context, snapshot.data[index]);
                      },
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color.fromARGB(
                                255, 167, 229, 255), // Adjust to your light color theme
                          ),
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                snapshot.data[index]['sender'],
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 18,
                                  color:
                                  Colors.black, // Adjust to your light color theme
                                ),
                              ),
                              Text(
                                snapshot.data[index]['title'],
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 18,
                                  color:
                                  Colors.black, // Adjust to your light color theme
                                ),
                              ),
                              Text(
                                snapshot.data[index]['date'],
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 18,
                                  color:
                                  Colors.black, // Adjust to your light color theme
                                ),
                              ),
                              Text(
                                snapshot.data[index]['receiver'],
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 18,
                                  color:
                                  Colors.black, // Adjust to your light color theme
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
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0)
        ),

          backgroundColor: Color.fromARGB(
              255, 233, 242, 243),
      child:  Container(
        width: 600,
        height: 500,
        padding: EdgeInsets.all(20.0),
        child: Scrollbar(child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('مکتوب ځواب شوی',style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
              textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0,),
              Text(
                data['description'],
                style: TextStyle(
                  color: Colors.black, // Adjust text color
                  fontSize: 16.0,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20,),
          ElevatedButton.icon(
            style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
                    return Colors.blue.withOpacity(0.5);
                  }
                  return Colors.blue; // Adjust button color
                },
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            onPressed: () {
              print('Resend Petition button');
              Navigator.pop(context);
            },
            icon: Icon(Icons.done,
                color: Colors.white,
                size: 30), // Adjust icon color and size
            label: Text(
              'اوکی',
              style: TextStyle(
                color: Colors.white,
                // Adjust text color
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

            ],
          ),
        ),

        ),
      )


      );
    },


    
  );
}
