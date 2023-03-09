import 'package:flutter/material.dart';
import '/constants/colors.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '/screens/myLoadPages/myLoadsScreen.dart';
import 'add_user_screen.dart';
import 'company_details.dart';
import 'login.dart';
import 'package:sizer/sizer.dart';
import '../logo.dart';

class HomeScreenWeb extends StatefulWidget {
  const HomeScreenWeb({Key? key}) : super(key: key);

  @override
  State<HomeScreenWeb> createState() => _HomeScreenWebState();
}

class _HomeScreenWebState extends State<HomeScreenWeb> {
  int _selectedIndex = 0;
  List<NavigationRailDestination> destinations = [
    const NavigationRailDestination(icon: Icon(Icons.space_dashboard), label: Text("Dashboard")),
    const NavigationRailDestination(icon: Icon(Icons.inventory_2_rounded), label: Text("My Loads")),
    const NavigationRailDestination(icon: Icon(Icons.receipt_long), label: Text("Invoice")),
    const NavigationRailDestination(icon: Icon(Icons.person_outline_outlined), label: Text("Account")),
    const NavigationRailDestination(icon: Icon(Icons.support_agent_outlined), label: Text("Help and Support")),
    const NavigationRailDestination(icon: Icon(Icons.phone_in_talk_outlined), label: Text("Contact Us")),
    const NavigationRailDestination(icon: Icon(Icons.logout_outlined), label: Text("Logout")),
  ];

  List<Widget> screens= const [
    LoginScreen(),MyLoadsScreen(),AddUser(),
    LoginScreen(),CompanyDetails(),AddUser(),
    LoginScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kLiveasyColor,
        title: TextButton(
          onPressed: (){
           // print("Liveasy");
          },
          child: SizedBox(
            width: kIsWeb?8.8.w:8.9.w,
            child: Row(
              children: [
                const ShipperImage(),
                SizedBox(width: 0.5.w,),
                Text('Liveasy',style: TextStyle(fontFamily: 'Montserrat',fontWeight: FontWeight.bold,fontSize: 5.sp,color: Colors.white),),
              ],
            ),
          ),
        ),
        actions: [
          SizedBox(
            width: 48,
            height: 40,
            child: TextButton.icon(onPressed: (){}, icon: const Icon(Icons.notifications_none_outlined,color: Colors.white,), label: const Text('')),
          ),
          SizedBox(
            width: 48,
            height: 40,
            child: TextButton.icon(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>screens[0]));
                  },
                icon: const Icon(Icons.search_outlined,color: Colors.white,), label: const Text('')),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: SizedBox(
              width: 48,
              height: 40,
              child: TextButton.icon(onPressed: (){}, icon: const Icon(Icons.account_circle_rounded,color: Colors.white,), label: const Text('')),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          NavigationRail(
            extended: true,
            selectedIconTheme: const IconThemeData(color: kLiveasyColor),
            unselectedLabelTextStyle: TextStyle(fontFamily: 'Montserrat',fontWeight: FontWeight.bold,fontSize: 3.6.sp,color: Colors.black),
            selectedLabelTextStyle: TextStyle(fontFamily: 'Montserrat',fontWeight: FontWeight.bold,fontSize: 3.9.sp,color: kLiveasyColor),
            indicatorColor: const Color(0xFFC4C4C4),
            labelType: kIsWeb?NavigationRailLabelType.none:NavigationRailLabelType.all,
            destinations: destinations,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index){
              setState(() {
                _selectedIndex = index;
              });
            },
            elevation: 20,
          ),
          const VerticalDivider(thickness: 1,width: 1,),
          Expanded(child: Center(child: screens[_selectedIndex],))
        ],
      ),
    );
  }
}
