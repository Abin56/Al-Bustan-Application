import 'package:canteen_productadd_application/controller/push_notification/push_notification.dart';
import 'package:canteen_productadd_application/controller/search_product_controller/search_product_controller.dart';
import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/core/shared_pref/user_auth/user_credentials.dart';
import 'package:canteen_productadd_application/view/fonts/google_poppins.dart';
import 'package:canteen_productadd_application/view/home/employee/pages/add_product/list%20products/product_list.dart';
import 'package:canteen_productadd_application/view/home/employee/pages/delivery_management/delivery_Histroy/deliveryHistory_page.dart';
import 'package:canteen_productadd_application/view/home/wareHouse_admin/AllProduct/allProduct.dart';
import 'package:canteen_productadd_application/view/home/wareHouse_admin/AvailableProduct/availableproduct.dart';
import 'package:canteen_productadd_application/view/home/wareHouse_admin/DeliveryOrders/deliveryOrders.dart';
import 'package:canteen_productadd_application/view/home/wareHouse_admin/DeliveryRequest/deliveryRequest.dart';
import 'package:canteen_productadd_application/view/home/wareHouse_admin/LowStockAlert/lowStockAlert.dart';
import 'package:canteen_productadd_application/view/home/wareHouse_admin/PendingOrders/pendingOrders.dart';
import 'package:canteen_productadd_application/view/home/wareHouse_admin/PickedOrders/pickedOrders.dart';
import 'package:canteen_productadd_application/view/home/wareHouse_admin/returns/returns.dart';
import 'package:canteen_productadd_application/view/home/wareHouse_admin/warhouse.dart';
import 'package:canteen_productadd_application/view/pages/login/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class WareHouseAdminNavBar extends StatefulWidget {
  final PushNotificationController pushNotificationController =
      Get.put(PushNotificationController());
  final SearchProductController searchProductController =
      Get.put(SearchProductController());

  WareHouseAdminNavBar({super.key});

  @override
  State<WareHouseAdminNavBar> createState() => _WareHouseAdminNavBarState();
}

class _WareHouseAdminNavBarState extends State<WareHouseAdminNavBar> {
  int _selectedIndex = 0;
  final TextStyle optionStyle =
      const TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static final List<Widget> _widgetOptions = <Widget>[
    WareHouseHomePage(),
    WareHouseHomePage(),
    const DeliveryHistoryPage(),
    ProductList()
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
            // ExpansionTile(
            //   title: Container(
            //     color: cWhite,
            //     child: GooglePoppinsWidgets(
            //       fontsize: 18,
            //       text: 'Request Access',
            //     ),
            //   ),
            //   children: <Widget>[
            //     GestureDetector(
            //       onTap: () {
            //         Get.to(StoreAdminRequest);
            //       },
            //       child: ListTile(
            //         leading: const Icon(
            //           Icons.circle,
            //           size: 10,
            //         ),
            //         title:
            //             GooglePoppinsWidgets(text: 'Store Admin', fontsize: 16),
            //         onTap: () {
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) => const StoreAdminRequest()),
            //           );
            //         },
            //       ),
            //     ),
            //     ListTile(
            //       leading: const Icon(
            //         Icons.circle,
            //         size: 10,
            //       ),
            //       title: GooglePoppinsWidgets(
            //           text: 'Delivery Admin', fontsize: 16),
            //       onTap: () {},
            //     ),
            //     ListTile(
            //       leading: const Icon(
            //         Icons.circle,
            //         size: 10,
            //       ),
            //       title: GooglePoppinsWidgets(
            //           text: 'Warehouse Admin', fontsize: 16),
            //       onTap: () {},
            //     ),
            //   ],
            // ),
            const ListTile(
              leading: Icon(
                Icons.dashboard,
              ),
              title: Text("Dashboard"),
            ),

            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const WareHouseAdminAllProduct();
                }));
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
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const WareadminAvailableProduct();
                }));
              },
              child: const ListTile(
                leading: Icon(
                  Icons.event_available,
                ),
                title: Text("Available Product"),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const wareAdminDeliveryRequest();
                }));
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
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const wareAdminPendingOrders();
                }));
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
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const WareAdminPickedOrders();
                }));
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
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const WareAdminDeliveryOrders();
                }));
              },
              child: const ListTile(
                leading: Icon(
                  Icons.trolley,
                ),
                title: Text("Delivered Orders"),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const WareAdminLowCostAlert();
                }));
              },
              child: const ListTile(
                leading: Icon(
                  Icons.notification_important,
                ),
                title: Text("Low Stock Alert"),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const WarwAdminReturns();
                }));
              },
              child: const ListTile(
                leading: Icon(
                  Icons.autorenew_rounded,
                ),
                title: Text("Returns"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
