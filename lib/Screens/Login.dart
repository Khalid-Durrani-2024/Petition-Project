import 'package:flutter/material.dart';
import 'package:petition/Assets/NetworkImages.dart';
import 'package:petition/Authentication/AuthData.dart';
import 'package:petition/Authentication/AuthWrapper.dart';
import 'package:petition/Colors/Colors.dart';
import 'package:petition/Screens/ForgotPassword.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 222, 223, 223),
      body: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}
List<String> _users = [
  'یوزر نوع انتخاب کړی',
  'وزارت',
  'پوهنتون',
  'پوهنځی'
];
bool isHover=false;
bool isObsecure=true;
String _selectedType=_users.first;
class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  AuthData().getSharedData();
  }
  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      
      child: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(

                   //Email Field
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                      color: Colors.white,
      
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0,5)
                      )
                    ]
                      ),

                  width: width *0.4,
                  child: Column(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        child: CircleAvatar(backgroundImage:
                          NetworkImage(ministryImage),),
                      ),
                      const Text(
                        'ننوتل',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(height: height/30,),
                      Container(
                        width: width *0.2,
                        padding: const EdgeInsets.symmetric(horizontal:
                        16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22)
                        ),
                        child: DropdownButtonFormField<String>(
                          borderRadius: BorderRadius.circular(22),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              // icon: Icon(Icons.arrow_drop_down_circle_sharp),
                              fillColor: Colors.grey.shade200,
                              filled: true),
                          dropdownColor: Colors.grey.shade300,
                          isExpanded: true,
                          hint: Text('انتخاب کړۍ'),
                          validator: (value) {
                            if (value!.isEmpty ||
                                value == '' ||
                                value == _users.first) {
                              return 'د یوزر نوعه انتخاب کړۍ انتخاب کړۍ';
                            }
                          },
                          value: _selectedType,
                          items: _users.map((String e) {
                            return DropdownMenuItem<String>(
                              value: e,
                              child: Text(
                                e,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (cha) {
                            _selectedType = cha!;
                          },
                        ),
                      ),
                      SizedBox(height: height/30,),
                      Container(
                        width: width*0.8,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(22)
                        ),
                        child: TextFormField(
                          textDirection: TextDirection.rtl,
                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'ایمیل ادرس مو دننه کړۍ';
                            } else if (!value.contains('@')) {
                              return 'خپل ایمیل ادرس مو چیک کړۍ او بیا هڅه وکړۍ "@"';
                            } else if (!value.contains('.')) {
                              return 'خپل ایمیل ادرس مو چیک کړۍ او بیا هڅه وکړۍ "."';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              color: Colors.black),
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email_outlined,color: Colors.black,),
                              border: InputBorder.none,
                              fillColor: Colors.grey.shade200,
                              filled: true,
                              labelStyle: TextStyle(

                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                              label: Text('ایمیل'),
                              alignLabelWithHint: true
                          ),
                        ),
                      ),



                SizedBox(
                  height: height / 30,
                ),
                Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(22)),
                  width: width *0.8,
                  child: TextFormField(
        
                    textDirection: TextDirection.rtl,
                    controller: passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'پټ نوم دننه کړۍ';
                      }
                      return null;
                    },
                    obscureText: isObsecure==true?true:false,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      prefixIcon:GestureDetector(
                          onTap: (){
                            setState(() {
        
                            if(isObsecure==true){
                              isObsecure=false;
                            }else{
                              isObsecure=true;
        
                            }
                            });
        
                          },
                          child: isObsecure==true?Icon(Icons.visibility,color: Colors.black,):
                      Icon(Icons.visibility_off,color: Colors.black)),
                        border: InputBorder.none,
                        labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                        label: Text('پټ نوم'),),
                  ),
                ),
                SizedBox(height: 30,),
                InkWell(
                  onTap: () async{
                    if (_formKey.currentState!.validate()){
                      await AuthData().authentication(emailController.text, passwordController.text,_selectedType);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AuthWrapper(),),);
        
                    }
                  },
                    onHover: (val){
                    setState(() {
                    isHover=val;
        
                    });
                    },
                  //Log In Button
                  child:Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: isHover?Colors.blue.shade700:Colors.blue,
                      boxShadow: isHover?[
                        BoxShadow(
                          color: Colors.blue.shade300,
                          blurRadius: 10,
                          offset: Offset(0,5),
                        )
                      ]:[]
                    ),
                    width: width*0.1,
                    height: height/15,
                  child: const Text('ننوتل',style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  ),
                  ),
                  )
                ),
                SizedBox(
                  height: height / 30,
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context) => ForgotPassword(),),);
                  },
                  child: const Text(
                    'پټ نوم مو هیر دی؟',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                )
              ],
            ),
    ),
        ]
    ),
    ),

    ),
    );
  }
}









//Log In Button Design on Hover
class SimpleLogIn extends StatefulWidget {
double width;
double height;
SimpleLogIn({required this.width,required this.height});

  @override
  State<SimpleLogIn> createState() => _SimpleLogInState();
}

class _SimpleLogInState extends State<SimpleLogIn> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: colors.buttonColor),
      width: widget.width / 5,
      height:widget.height / 15,
      child: const Text(
        'دننه شۍ',
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18),
      ),
    );

  }
}


//Log In Button Design on Hover

class DesignedLogIn extends StatefulWidget {
  double width;
  double height;

  DesignedLogIn({required this.width,required this.height});

  @override
  State<DesignedLogIn> createState() => _DesignedLogInState();
}

class _DesignedLogInState extends State<DesignedLogIn> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          color: colors.hoverColor,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      width: widget.width / 5,
      height:widget.height / 15,
      child: const Text(
        'دننه شۍ',
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18),
      ),
    );

  }
}
