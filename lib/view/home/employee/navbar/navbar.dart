import 'package:canteen_productadd_application/controller/push_notification/push_notification.dart';
import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/core/shared_pref/user_auth/user_credentials.dart';
import 'package:canteen_productadd_application/view/fonts/google_poppins.dart';
import 'package:canteen_productadd_application/view/home/employee/employee_profile_home.dart';
import 'package:canteen_productadd_application/view/home/employee/pages/add_product/list%20products/product_list.dart';
import 'package:canteen_productadd_application/view/home/employee/pages/delivery_management/delivery_Histroy/deliveryHistory_page.dart';
import 'package:canteen_productadd_application/view/home/storeadmin/store_admin_request_page/store_admin_req_page.dart';
import 'package:canteen_productadd_application/view/pages/login/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class NavigationBarPage extends StatefulWidget {
   final PushNotificationController pushNotificationController=PushNotificationController();
 NavigationBarPage({super.key});

  @override
  NavigationBarPageState createState() => NavigationBarPageState();
}

class NavigationBarPageState extends State<NavigationBarPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static final List<Widget> _widgetOptions = <Widget>[
    EmployeeProfileHomePage(),
    const DeliveryHistoryPage(),
    ProductList(),

    //  ProductList(),
// Text('Delivery'),
    // const StoreAdminRequest()
    //  ProductList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 20,
        backgroundColor: themeColorBlue,
        title: GooglePoppinsWidgets(
          text: 'Al-Bustan',
          fontsize: 25,
          fontWeight: FontWeight.bold,
          color: cWhite,
        ),
                    actions: [
          IconButton(
              onPressed: () async {
                Get.offAll(() async {
                  await logoutUser();
                  return LoginScreen();
                });
              },
              icon: const Icon(Icons.power_settings_new_rounded))
        ],
        
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.shoppingCart,
                  text: 'Delivery',
                ),
                GButton(
                  icon: LineIcons.history,
                  text: 'History',
                ),

                // GButton(
                //   icon: LineIcons.shoppingCart,
                //   text: 'Delivery',
                // ),
                // GButton(
                //   icon: LineIcons.user,
                //   text: 'Profile',
                // ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(),
                child: Column(
                  children: [
                    GooglePoppinsWidgets(
                      text: 'ALBUSTAN',
                      fontsize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage("images/albustanblack.png"))),
                        ),
                      ],
                    ),
                  ],
                )),
            ExpansionTile(
              title: Container(
                color: cWhite,
                child: GooglePoppinsWidgets(
                  fontsize: 18,
                  text: 'Request Access',
                ),
              ),
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Get.to(StoreAdminRequest);
                  },
                  child: ListTile(
                    leading: const Icon(
                      Icons.circle,
                      size: 10,
                    ),
                    title:
                        GooglePoppinsWidgets(text: 'Store Admin', fontsize: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StoreAdminRequest()),
                      );
                    },
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.circle,
                    size: 10,
                  ),
                  title: GooglePoppinsWidgets(
                      text: 'Delivery Admin', fontsize: 16),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(
                    Icons.circle,
                    size: 10,
                  ),
                  title: GooglePoppinsWidgets(
                      text: 'Warehouse Admin', fontsize: 16),
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
