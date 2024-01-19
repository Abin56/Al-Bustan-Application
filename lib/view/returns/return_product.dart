import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Returns extends StatefulWidget {
  const Returns({super.key});

  @override
  ReturnsState createState() => ReturnsState();
}

class ReturnsState extends State<Returns> {
  List<bool> isIconChangedList = List.generate(6, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Returns'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Go to the next page',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const ReturnsSearchScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            margin: const EdgeInsets.all(6),
            child: ListTile(
              leading: _buildProductImage(),
              title: Text(
                "Product $index",
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text("Description of Product $index"),
              onTap: () => _onProductTap(index),
              trailing: _buildProductCheckbox(index),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductImage() {
    return ClipOval(
      child: Image.network(
        "https://images.ctfassets.net/hrltx12pl8hq/28ECAQiPJZ78hxatLTa7Ts/2f695d869736ae3b0de3e56ceaca3958/free-nature-images.jpg?fit=fill&w=1200&h=630",
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
    );
  }

  void _onProductTap(int index) {
    print('Item clicked: Product $index');
  }

  Widget _buildProductCheckbox(int index) {
    return Checkbox(
      value: isIconChangedList[index],
      activeColor: Colors.green,
      onChanged: (value) => _onCheckboxChanged(index, value),
    );
  }

  void _onCheckboxChanged(int index, bool? value) {
    setState(() {
      isIconChangedList[index] = value ?? false;
    });
    print('Product $index');
  }
}

// <<<<<<<<< Search Screen >>>>>>>>>>>>>>

class ReturnsSearchScreen extends StatelessWidget {
  const ReturnsSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CupertinoSearchTextField(
                placeholder: 'Search',
                // onSubmitted: (String value) {
                //   print('Search query: $value');
                // },
              ),
            ],
          ),
        ),
      ),
      child: SizedBox(),
    );
  }
}
