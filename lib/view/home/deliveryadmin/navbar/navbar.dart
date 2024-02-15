import 'package:canteen_productadd_application/controller/push_notification/push_notification.dart';
import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/core/shared_pref/user_auth/user_credentials.dart';
import 'package:canteen_productadd_application/view/fonts/google_poppins.dart';
import 'package:canteen_productadd_application/view/home/deliveryadmin/delivered/delivered.dart';
import 'package:canteen_productadd_application/view/home/deliveryadmin/delivery_assign/delivery_assign.dart';
import 'package:canteen_productadd_application/view/home/deliveryadmin/delivery_pending/delivery_pending.dart';
import 'package:canteen_productadd_application/view/home/deliveryadmin/delivery_picked/delivery_picked.dart';
import 'package:canteen_productadd_application/view/home/deliveryadmin/delivery_product/delivery_product.dart';
import 'package:canteen_productadd_application/view/home/deliveryadmin/delivery_request/delivery_request.dart';
import 'package:canteen_productadd_application/view/home/deliveryadmin/deliveryadmin.dart';
import 'package:canteen_productadd_application/view/home/employee/pages/add_product/list%20products/product_list.dart';
import 'package:canteen_productadd_application/view/home/employee/pages/delivery_management/delivery_Histroy/deliveryHistory_page.dart';
import 'package:canteen_productadd_application/view/pages/login/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class DeliveryAdminNavBar extends StatefulWidget {
  final PushNotificationController pushNotificationController =
      Get.put(PushNotificationController());
  DeliveryAdminNavBar({super.key});

  @override
  State<DeliveryAdminNavBar> createState() => _DeliveryAdminNavBarState();
}

class _DeliveryAdminNavBarState extends State<DeliveryAdminNavBar> {
  int _selectedIndex = 0;
  final TextStyle optionStyle =
      const TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static final List<Widget> _widgetOptions = <Widget>[
    DeliveryProductScreen(),
    DeliveryRequest(),
    DeliveryAssign(),
    DeliveryPendingList(),
    DeliveryPickedUpList(),
    DeliveredList()
    // const DeliveryAdminHomePage(),

    //ProductList(),
    // const DeliveryHistoryPage(),
    // ProductList()
    // Text(
    //   'Delivery',
    //   style: optionStyle,
    // ),
    //  ProductList(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: cWhite,
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
                await logoutUser();
              },
              icon: const Icon(
                Icons.power_settings_new_rounded,
                color: cWhite,
              ))
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
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
            InkWell(
              child: const ListTile(
                leading: Icon(
                  Icons.dashboard,
                ),
                title: Text("Dashboard"),
              ),
            ),
            InkWell(
              onTap: () {
                // Get.to(DeliveryProductScreen());
                setState(() {
                  _selectedIndex = 0;
                });
              },
              child: const ListTile(
                leading: Icon(
                  Icons.food_bank,
                ),
                title: Text("All Product"),
              ),
            ),
            InkWell(
              onTap: () {
                // Get.to(const DeliveryRequest());
                setState(() {
                  _selectedIndex = 1;
                });
              },
              child: const ListTile(
                leading: Icon(
                  Icons.request_quote,
                ),
                title: Text("Delivery Request"),
              ),
            ),
            InkWell(
              onTap: () {
                // Get.to(DeliveryAssign());
                setState(() {
                  _selectedIndex = 2;
                });
              },
              child: const ListTile(
                leading: Icon(
                  Icons.event_available,
                ),
                title: Text("Delivery Assign List"),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _selectedIndex = 3;
                });
              },
              child: const ListTile(
                leading: Icon(
                  Icons.pending_actions_sharp,
                ),
                title: Text("Pending Orders"),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _selectedIndex = 4;
                });
              },
              child: const ListTile(
                leading: Icon(
                  Icons.shopping_bag_outlined,
                ),
                title: Text("Picked Orders"),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _selectedIndex = 5;
                });
              },
              child: const ListTile(
                leading: Icon(
                  Icons.trolley,
                ),
                title: Text("Delivered Orders"),
              ),
            ),
          ],
        ),
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
                  text: 'Delivery Req',
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
    );
  }
}
