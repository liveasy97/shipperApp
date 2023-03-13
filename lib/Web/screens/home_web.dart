import 'package:flutter/material.dart';
import 'package:shipper_app/Widgets/accountVerification/accountPageUtil.dart';
import 'package:shipper_app/responsive.dart';
import 'package:shipper_app/screens/HelpScreen.dart';
import 'package:shipper_app/screens/PostLoadScreens/postLoadScreen.dart';
import '/constants/colors.dart';
import '/screens/myLoadPages/myLoadsScreen.dart';
import 'add_user_screen.dart';
import 'package:sizer/sizer.dart';
import '../logo.dart';

class HomeScreenWeb extends StatefulWidget {
  const HomeScreenWeb({Key? key}) : super(key: key);

  @override
  State<HomeScreenWeb> createState() => _HomeScreenWebState();
}

class _HomeScreenWebState extends State<HomeScreenWeb> {
  int _selectedIndex = 0;
  int _index = 0;
  List<NavigationRailDestination> destinations = [
    const NavigationRailDestination(icon: Icon(Icons.space_dashboard), label: Text("Dashboard")),
    const NavigationRailDestination(icon: Icon(Icons.inventory_2_rounded), label: Text("My Loads")),
    const NavigationRailDestination(icon: Icon(Icons.receipt_long), label: Text("Invoice")),
    const NavigationRailDestination(icon: Icon(Icons.person_outline_outlined), label: Text("Account")),
    const NavigationRailDestination(icon: Icon(Icons.support_agent_outlined), label: Text("Help and Support")),
    const NavigationRailDestination(icon: Icon(Icons.phone_in_talk_outlined), label: Text("Contact Us")),
    const NavigationRailDestination(icon: Icon(Icons.logout_outlined), label: Text("Logout")),
  ];

  List<Widget> screens= [
    PostLoadScreen(),
    PostLoadScreen(),
    AddUser(),
    AccountPageUtil(),
    HelpScreen(),
    AddUser(),
    AccountPageUtil(),
    MyLoadsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kLiveasyColor,
        title: TextButton(
          onPressed: (){
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreenWeb()));
          },
          child: SizedBox(
            width: 9.w,
            child: Row(
              children: [
                const ShipperImage(),
                SizedBox(width: 0.5.w,),
                Text('Liveasy',style: TextStyle(fontFamily: 'Montserrat',fontWeight: FontWeight.bold,fontSize: Responsive.isDesktop(context)?5.sp:4.5.sp,color: Colors.white),),
              ],
            ),
          ),
        ),
        actions: [
          SizedBox(
            width: 48,
            height: 40,
            child: TextButton.icon(onPressed: (){
              setState(() {
                _index = 5;
              });
            }, icon: const Icon(Icons.notifications_none_outlined,color: Colors.white,), label: const Text('')),
          ),
          SizedBox(
            width: 48,
            height: 40,
            child: TextButton.icon(
                onPressed: (){
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>screens[0]));
                  setState(() {
                    _index = 7;
                  });
                  },
                icon: const Icon(Icons.search_outlined,color: Colors.white,), label: const Text('')),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: SizedBox(
              width: 48,
              height: 40,
              child: TextButton.icon(onPressed: (){
                setState(() {
                  _index = 6;
                });
              }, icon: const Icon(Icons.account_circle_rounded,color: Colors.white,), label: const Text('')),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          NavigationRail(
            extended: Responsive.isDesktop(context)?true:false,
            selectedIconTheme: const IconThemeData(color: kLiveasyColor),
            unselectedLabelTextStyle: TextStyle(fontFamily: 'Montserrat',fontWeight: FontWeight.bold,fontSize: 3.6.sp,color: Colors.black),
            selectedLabelTextStyle: TextStyle(fontFamily: 'Montserrat',fontWeight: FontWeight.bold,fontSize: 3.9.sp,color: kLiveasyColor),
            indicatorColor: const Color(0xFFC4C4C4),
            labelType: Responsive.isDesktop(context)?NavigationRailLabelType.none:NavigationRailLabelType.all,
            destinations: destinations,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index){
              setState(() {
                _selectedIndex = index;
                _index = index;
              });
            },
            elevation: 20,
          ),
          const VerticalDivider(thickness: 1,width: 1,),
          Expanded(child: Center(child: screens[_index],))
        ],
      ),
    );
  }
}
