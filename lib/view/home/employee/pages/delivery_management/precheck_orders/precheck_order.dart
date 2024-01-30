import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/constant/const.dart';
import 'package:canteen_productadd_application/view/core/core.dart';
import 'package:canteen_productadd_application/view/fonts/google_poppins.dart';
import 'package:canteen_productadd_application/view/home/employee/pages/delivery_management/precheck_orders/ui_templates.dart';
import 'package:flutter/material.dart';

class PreCheckordersScreen extends StatelessWidget {
  const PreCheckordersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.9),
      appBar: AppBar(
        title: GooglePoppinsWidgets(
          text: "PRE-CHECK ORDERS",
          fontsize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 500,
          child: Column(
            children: [
              const SizedBox(
                height: 60,
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                        flex: 1, child: TableHeaderWidget(headerTitle: 'No')),
                    SizedBox(
                      width: 01,
                    ),
                    Expanded(
                        flex: 10,
                        child: TableHeaderWidget(headerTitle: 'Product Name')),
                    SizedBox(
                      width: 01,
                    ),
                    Expanded(
                        flex: 5, child: TableHeaderWidget(headerTitle: 'QTY')),
                    SizedBox(
                      width: 01,
                    ),
                    Expanded(
                        flex: 5,
                        child: TableHeaderWidget(headerTitle: 'Check')),
                  ],
                ),
              ),
              StreamBuilder(
                  stream: dataserver
                      .collection('AllUsersCollection')
                      // .where('userrole', isEqualTo: 'employee')
                      .orderBy('name', descending: false)
                      .snapshots(),
                  builder: (context, employesnaps) {
                    if (employesnaps.hasData) {
                      return Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 1),
                                child: SizedBox(
                                  height: 50,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: DataContainerWidget2(
                                            rowMainAccess:
                                                MainAxisAlignment.center,
                                            color: cWhite,
                                            // width: 150,
                                            index: index,
                                            headerTitle: '${index + 1}'),
                                      ),
                                      const SizedBox(
                                        width: 01,
                                      ),
                                      Expanded(
                                        flex: 10,
                                        child: DataContainerWidget2(
                                            rowMainAccess:
                                                MainAxisAlignment.start,
                                            color: cWhite,
                                            // width: 150,
                                            index: index,
                                            headerTitle: ' APPLE '),
                                      ),
                                      const SizedBox(
                                        width: 01,
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: DataContainerWidget2(
                                            rowMainAccess:
                                                MainAxisAlignment.center,
                                            color: cWhite,
                                            // width: 150,
                                            index: index,
                                            headerTitle: '100'),
                                      ),
                                      const SizedBox(
                                        width: 01,
                                      ),
                                      Expanded(
                                          flex: 5,
                                          child: Container(
                                            height: 45,
                                            decoration: const BoxDecoration(
                                              color: cWhite,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                    onPressed: () async {},
                                                    icon: const Icon(
                                                      Icons.cancel_outlined,
                                                      color: cred,
                                                      size: 30,
                                                    )),
                                                IconButton(
                                                    onPressed: () async {},
                                                    icon: const Icon(
                                                      Icons
                                                          .check_circle_outline_outlined,
                                                      color: cGreen,
                                                      size: 30,
                                                    )),
                                              ],
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              );

                              // final data = UserModel.fromMap(
                              //     employesnaps.data!.docs[index].data());

                              // return UserDataListWidget(
                              //   datalist: data,
                              //   index: index,
                              // );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 0,
                              );
                            },
                            itemCount: employesnaps.data!.docs.length),
                      );
                    } else {
                      return const Center(
                        child: circularPIndicator,
                      );
                    }
                  })
            ],
          ),
        ),
      )),
    );
  }
}
