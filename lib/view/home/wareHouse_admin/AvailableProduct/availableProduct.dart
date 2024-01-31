import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:flutter/material.dart';

class WareadminAvailableProduct extends StatelessWidget {
  const WareadminAvailableProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Product",
            style: TextStyle(color: Colors.white)),
        leading: const Icon(Icons.arrow_back),
        backgroundColor: themeColorBlue,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            height: 1000,
            width: 900,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          //width: 50,
                          color: const Color.fromARGB(255, 121, 191, 248),
                          child: const Center(
                              child: Text(
                            "SL.No",
                            style: TextStyle(fontSize: 17),
                          )),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 50,
                        // width: 80,
                        color: const Color.fromARGB(255, 121, 191, 248),
                        child: const Center(
                            child: Text(
                          "Item Name",
                          style: TextStyle(fontSize: 17),
                        )),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          //width: 120,
                          color: const Color.fromARGB(255, 121, 191, 248),
                          child: const Center(
                              child: Text(
                            "Main Category",
                            style: TextStyle(fontSize: 17),
                          )),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 50,
                        // width: 120,
                        color: const Color.fromARGB(255, 121, 191, 248),
                        child: const Center(
                            child: Text(
                          "Sub Category",
                          style: TextStyle(fontSize: 17),
                        )),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          // width: 60,
                          color: const Color.fromARGB(255, 121, 191, 248),
                          child: const Center(
                              child: Text(
                            "Unit",
                            style: TextStyle(fontSize: 17),
                          )),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 50,
                        //width: 80,
                        color: const Color.fromARGB(255, 121, 191, 248),
                        child: const Center(
                            child: Text(
                          "Packaging",
                          style: TextStyle(fontSize: 17),
                        )),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          width: 80,
                          color: const Color.fromARGB(255, 121, 191, 248),
                          child: const Center(
                              child: Text(
                            "Company",
                            style: TextStyle(fontSize: 17),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 50,
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 8),
                              child: Container(
                                //  height: 50,
                                width: 58,
                                color: Colors.blue[50],
                                child: const Center(child: Text("1")),
                              ),
                            ),
                            Container(
                              // height: 50,
                              width: 150,
                              color: Colors.blue[50],
                              child: const Center(
                                  child: SingleChildScrollView(
                                      child: Text("Apple"))),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Container(
                                // height: 50,
                                width: 130,
                                color: Colors.blue[50],
                                child: const Center(child: Text("food")),
                              ),
                            ),
                            Container(
                              // height: 50,
                              width: 150,
                              color: Colors.blue[50],
                              child: const Center(child: Text("fruits")),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Container(
                                //height: 50,
                                width: 65,
                                color: Colors.blue[50],
                                child: const Center(child: Text("1kg")),
                              ),
                            ),
                            Container(
                              // height: 50,
                              width: 150,
                              color: Colors.blue[50],
                              child: const Center(child: Text("Packaging")),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Container(
                                // height: 50,
                                width: 130,
                                color: Colors.blue[50],
                                child: const Center(child: Text("royal")),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: 10,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
