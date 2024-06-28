import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logiwithdata/Logins/Signup.dart';
import 'package:logiwithdata/Logins/user.dart';
import 'package:logiwithdata/SqlLite/mysql.dart';


import 'Views/Notes.dart';
class Login extends StatefulWidget{
  @override
  const Login({
    super.key
  });

  State<Login>createState()=>_MyWidgetState();

}
class _MyWidgetState extends State<Login>{
final title = TextEditingController();
  final username=TextEditingController();
  final password = TextEditingController();
  bool isVisible =false;bool islog=false;
final db =DatabaseHelper();
login()async{
var respo= await db.login(Users(usrName:username.text,usrPassword:password.text));

if(respo==true){if(!mounted)return;
  Navigator.push(context, MaterialPageRoute(builder: (context)=> const Notes()));
}else {
  setState(() {
    islog=true;
  });
}
}
  final FormKey=GlobalKey<FormState>();
  Widget build (BuildContext context){
    return   Scaffold(
body: Center(
  child:SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: FormKey,
        child: Column(
          children: [
            Image.asset("Assets/Images/icons.jpeg"),
            SizedBox(height: 100,),
            //Username
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
            SizedBox(height: 5,),
            //password
            Container(
              margin:const EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
              decoration: BoxDecoration(borderRadius:BorderRadius.circular(12),color: Colors.deepPurple.withOpacity(.3)),
              child: TextFormField(controller: password,

                validator: (value){
                  if(value!.isEmpty)return "Password Is Required";
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
                  if(FormKey.currentState!.validate()){
login();
                  }
                }, child: Text('Login',style: TextStyle(color: Colors.white),))),
            Row(mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text("Don't Have an account?"),
                TextButton(onPressed: (){
Navigator.push(context, MaterialPageRoute(builder: (context)=>const Signup()));
                }, child: Text('Sign up'))
              ],
            ),
           islog? const Text('Username or Password is Incorrect',style: (TextStyle(color: Colors.redAccent) ),):const SizedBox()
          ],
        ),
      ),
    ),
  )

),
    );
  }
}