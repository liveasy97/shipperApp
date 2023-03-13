import 'dart:developer';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import '/Web/screens/home_web.dart';
import '/Widgets/liveasy_Icon_Widgets.dart';
import 'company_details.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '/../functions/alert_dialog.dart';

class LoginScreenWeb extends StatefulWidget {
  const LoginScreenWeb({Key? key}) : super(key: key);

  @override
  State<LoginScreenWeb> createState() => _LoginScreenWebState();
}

class _LoginScreenWebState extends State<LoginScreenWeb> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController otpController = TextEditingController();
  late String phoneNumber;
  late ConfirmationResult confirmationResult;
  bool passwordVisible = true;
  bool isChecked = false;
  bool isError = false;
  bool isVerified = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const LiveasyIcon(),
              Form(
                key: _formKey,
                child: Container(
                  width: kIsWeb?35.w:40.w,
                  height: isError?55.h:50.h,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 3.w,top: 5.h),
                        child: const Text('Phone Number',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 3.w,top: 1.h,right: 4.w),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: '98xxxxxx12',
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                            ),
                          ),
                          validator: (value){
                            if(value.toString().isEmpty){
                              setState(() {
                                isError = true;
                              });
                              return "Enter your Phone Number";
                            }
                            if(value.toString().length != 10){
                              setState(() {
                                isError = true;
                              });
                              return "Invalid Phone NUmber";
                            }
                            setState(() {
                              isError = false;
                            });
                            return null;
                          },
                          onSaved: (value){
                            phoneNumber = value.toString();
                          },
                        ),
                      ),
                      isVerified?showOTPField():SizedBox(height: 2.h,),
                      Padding(
                        padding: EdgeInsets.only(left: 3.w,top: 1.h),
                        child: TextButton.icon(
                          onPressed: (){
                            setState(() {
                              isChecked=!isChecked;
                            });
                          },
                          icon: isChecked?const Icon(Icons.check_box,)
                                         :const Icon(Icons.check_box_outline_blank,color: Colors.black,),
                          label: const Text("Keep me logged in",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      isVerified ? buildButton('Sign In', () async{
                        var temp = await checkOTP(otpController.text.toString());
                        if(temp.uid!=null && temp.email==null){
                          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>const CompanyDetails()));
                        }else{
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreenWeb()));
                        }
                      }) : buildButton('Send OTP',() async{
                        if(_formKey.currentState!.validate()){
                          _formKey.currentState!.save();
                          await sigIn(phoneNumber);
                          if(confirmationResult.verificationId.isNotEmpty){
                            setState(() {
                              isVerified = true;
                            });
                          }
                        }
                      }),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //Elevated Button for both send otp and sign in functionalities
  buildButton(String text,VoidCallback fun) {
    return Padding(
      padding: EdgeInsets.only(left: 3.w,top: 5.h,right: 1.w),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),),
          backgroundColor: const Color(0xFF000066),
          fixedSize: Size(28.w, 7.h),
        ),
        onPressed: fun,
        child: Text(text,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Montserrat',
            fontSize: 4.3.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  //OTP field is displayed only when user got otp to his specified number
  showOTPField(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left:kIsWeb?3.w:10,top: 3.h),
          child: const Text('OTP',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 18,
              fontWeight: FontWeight.bold,),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 3.w,top: 1.h,right: 4.w),
          child: PinCodeTextField(
            obscureText: true,
            obscuringCharacter: '*',
            animationType: AnimationType.fade,
            validator: (v){
              if(v!.length<6){
                return "Enter Valid OTP";
              }else{
                return null;
              }
            },
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: kIsWeb?50:40,
              fieldWidth: kIsWeb?40:30,
              activeColor: Colors.black,
              inactiveColor: Colors.black,
            ),
            cursorColor: Colors.black,
            keyboardType: TextInputType.number,
            controller: otpController,
            appContext: context,
            length: 6,
            onChanged: (value){},
          ),
        ),
      ],
    );
  }

  //Sign In functionality
  sigIn(String phoneNumber) async{
    await auth.signInWithPhoneNumber("+91$phoneNumber")
        .then((value) => {
          confirmationResult = value,
          alertDialog('OTP sent','OTP has been sent to +91$phoneNumber',context),
        })
        .catchError((error)=>{
          alertDialog('Error','Try again Later',context)
        });
  }

  //User entered otp verification and signing in
  checkOTP(String otp) async{
    late UserCredential userCredential;
    await confirmationResult.confirm(otp)
        .then((value) => {
          userCredential = value,
          log(''),
        })
        .catchError((error)=>{
          if(error.toString().contains('auth credential is invalid'))
            alertDialog('Error','Invalid OTP',context),
        });
    return userCredential.user;
  }
}
