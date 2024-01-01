import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/fonts/google_poppins.dart';
import 'package:flutter/material.dart';

class RequestListingHistoryPage extends StatelessWidget {
  const RequestListingHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemBuilder: (context, index) {
          return
         Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            height: 90,
            color: const Color.fromARGB(255, 154,45,210).withOpacity(0.2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column( 
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 30,
                      width: 60,
                      color: Colors.blue,
                      child: Center(child: GooglePoppinsWidgets(text: "Date", fontsize: 12)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GooglePoppinsWidgets(text: "Order ID", fontsize: 14),
                    )
                  ],
                ),
                
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GooglePoppinsWidgets(text: "Task Time", fontsize: 11,fontWeight: FontWeight.w600,),
                    GooglePoppinsWidgets(text: "10:00", fontsize: 12),
                    GooglePoppinsWidgets(text: "Target Time :", fontsize: 11,fontWeight: FontWeight.bold,)
                  ],
                ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GooglePoppinsWidgets(text: "Completed Time", fontsize: 11,fontWeight: FontWeight.w600,),
                    GooglePoppinsWidgets(text: "10:00", fontsize: 12),
                    GooglePoppinsWidgets(text: " 3 hrs", fontsize: 11,fontWeight: FontWeight.bold,)
                  ],
                ),
                Container(
                  width: 60,
                  height: double.infinity,
                  color: cGreen,
                  child: Center(child: GooglePoppinsWidgets(text: "Status", fontsize: 13,fontWeight: FontWeight.bold,)),
                )
              ],
            )
          ),
        );
         
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: 10,
      
      ),
    );
  }
}