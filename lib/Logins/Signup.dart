import 'package:flutter/material.dart';
import 'package:logiwithdata/Logins/user.dart';
import 'package:logiwithdata/SqlLite/mysql.dart';


import 'login.dart';
class Signup extends StatefulWidget{
  @override
const Signup({
    super.key
});

  State<Signup>createState()=>_MyWidgetState();

  }
  class _MyWidgetState extends State<Signup>{
    bool isValidPassword(String password) {
      if (password.length < 8) {return false;}
      bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
      if (!hasUppercase) {return false;}
      bool hasLowercase = password.contains(RegExp(r'[a-z]'));
      if (!hasLowercase) {return false;}

      bool hasDigit = password.contains(RegExp(r'[0-9]'));
      if (!hasDigit) {return false;}
      bool hasSpecialCharacter = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      if (!hasSpecialCharacter) {return false;}return true;
    }
  final username=TextEditingController();
  final password = TextEditingController();
  final confirmpassword =TextEditingController();
final Formkey=GlobalKey<FormState>();
bool isVisible=false;
  Widget build(BuildContext context){
    return  Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: Formkey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(


                mainAxisAlignment: MainAxisAlignment.center,
                children: [
SizedBox(height: 60,),
                  Image.asset("Assets/Images/signup.jpeg"),
                  const ListTile(
                    title: Text("           Register Here",style: TextStyle(
                        fontSize: 30,fontWeight: FontWeight.bold,color: Colors.deepPurple),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(8),

                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius:BorderRadius.circular(12),color: Colors.deepPurple.withOpacity(.3)),
                    child: TextFormField(
                      controller: username,
                      validator: (value){
                        if(value!.isEmpty)return "Username Is Required";
                        return null;
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        border: InputBorder.none,

                        hintText: "Username",
                      ),
                    ),
                  ),
                  Container(margin: EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                    decoration: BoxDecoration(borderRadius:BorderRadius.circular(12),color: Colors.deepPurple.withOpacity(.3)),
                    child: TextFormField(
                      controller: password,
                      validator: (value){
                        if(value!.isEmpty)return "Password Is Required";
                        else if(isValidPassword(value)==false)return "Password must contain one uppercase ,lower case length not less than 8 and one special char ";
                        return null;
                      },
                      obscureText: !isVisible,
                      decoration: InputDecoration(
                          icon: Icon(Icons.lock),
                          border: InputBorder.none,

                          hintText: "Password",
                          suffixIcon: IconButton(
                            onPressed: (){
                              setState(() {
                                isVisible=!isVisible;
                              });
                            },icon: Icon(isVisible?  Icons.visibility:Icons.visibility_off),
                          )
                      ),
                    ),
                  ),
                  Container(margin: EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                    decoration: BoxDecoration(borderRadius:BorderRadius.circular(12),color: Colors.deepPurple.withOpacity(.3)),
                    child: TextFormField(
                      controller: confirmpassword,
                      validator: (value){
                        if(value!.isEmpty)return "Password Is Required";
                        else if(password.text!=confirmpassword.text)return "Passwords Don't Match";
                        return null;
                      },
                      obscureText: !isVisible,
                      decoration: InputDecoration(
                          icon: Icon(Icons.lock),
                          border: InputBorder.none,

                          hintText: "Password",
                          suffixIcon: IconButton(
                            onPressed: (){
                              setState(() {
                                isVisible=!isVisible;
                              });
                            },icon: Icon(isVisible?  Icons.visibility:Icons.visibility_off),
                          )
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(height: 60,
                      width: MediaQuery.of(context).size.width * .9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.deepPurple
                      ),

                      child: TextButton(onPressed: (){
                        if(Formkey.currentState!.validate()){
final db =DatabaseHelper();
db.signup(Users(usrName: username.text, usrPassword: password.text)).whenComplete((){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>const Login()));
});
                        }
                      }, child: Text('SIGN UP',style: TextStyle(fontSize:25,color: Colors.white),))),
                  Row(mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text("Already Have an account?",style: TextStyle(fontSize: 23,fontWeight: FontWeight.w400),),
                      SizedBox(width: 5,),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const Login()));
                      }, child: Text('Log In',style: TextStyle(fontSize: 23,fontWeight: FontWeight.w400)))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  }

