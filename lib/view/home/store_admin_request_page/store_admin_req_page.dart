import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/fonts/google_poppins.dart';
import 'package:flutter/material.dart';

class StoreAdminRequest extends StatelessWidget {
  const StoreAdminRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(backgroundColor: themeColorBlue,title: GooglePoppinsWidgets(text: 'Al-Bustan', fontsize: 25,fontWeight: FontWeight.bold,color: cWhite,),),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: const CircleAvatar(
                radius: 30,
              ),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GooglePoppinsWidgets(text: 'Anu', fontsize: 15),
                  GooglePoppinsWidgets(text: 'anu@gmail.com', fontsize: 12),
                ],
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Container(
                              height: 30,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  border: Border.all(color: themeColorBlue),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: GooglePoppinsWidgets(
                                      text: 'Approved', fontsize: 13)),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Container(
                              height: 30,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  border: Border.all(color: themeColorBlue),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: GooglePoppinsWidgets(
                                      text: 'Denined', fontsize: 13)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 10,
            );
          },
          itemCount: 2),
    );
  }
}
