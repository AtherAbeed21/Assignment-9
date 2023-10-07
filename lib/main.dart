import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Interface',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          color: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      home: ShoppingInterface(),
    );
  }
}

class ShoppingInterface extends StatefulWidget {
  @override
  _ShoppingInterfaceState createState() => _ShoppingInterfaceState();
}

class _ShoppingInterfaceState extends State<ShoppingInterface> {
  Map<String, int> itemCounts = {"Pullover": 1, "T-shirt": 1, "Sport Dress": 1};
  double unitPrice = 20.0;

  void _incrementItem(String item) {
    setState(() {
      itemCounts[item] = itemCounts[item]! + 1;
    });
  }

  void _decrementItem(String item) {
    setState(() {
      itemCounts[item] = itemCounts[item]! > 0 ? itemCounts[item]! - 1 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalAmount = itemCounts.values.fold(0, (previous, count) => previous + (count * unitPrice));

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text("My Bag", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildClothItem("Pullover", "https://th.bing.com/th/id/OIP.hBfnG7GKOwR23-Xznx1bgwHaLs?pid=ImgDet&rs=1"),
                  _buildClothItem("T-shirt", "https://th.bing.com/th/id/R.340ccecab77e91c04f01f04368ecdd26?rik=NxKLVh4bZJkRMg&riu=http%3a%2f%2fi1.adis.ws%2ft%2fjpl%2fjd_product_list%3fplu%3djd_031921_a%26resmode%3dsharp&ehk=iCtNOhr3UjX1%2brKTPFIG7MV80fmfbkj6nwGpSIn%2fMec%3d&risl=&pid=ImgRaw&r=0"),
                  _buildClothItem("Sport Dress", "https://th.bing.com/th/id/R.7fb39db62eb606029768d383b701ce28?rik=2zkx%2b5cf2582jg&pid=ImgRaw&r=0"),
                ],
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Opacity(opacity: 0.6, child: Text("Total Amount")),
                Text("\$${totalAmount.toStringAsFixed(2)}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ],
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Congratulations on your checkout!"))
                );
              },
              child: Text("CHECK OUT"),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                onPrimary: Colors.white,
                textStyle: TextStyle(fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  Widget _buildClothItem(String title, String imageUrl) {
    return Container(
      height: 170,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Image.network(imageUrl, fit: BoxFit.cover),
              ),
              SizedBox(width: 15),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Opacity(opacity: 0.6, child: Text("Color:")),
                        SizedBox(width: 5),
                        Text("Red"),
                        SizedBox(width: 20),
                        Opacity(opacity: 0.6, child: Text("Size:")),
                        SizedBox(width: 5),
                        Text("M"),
                      ],
                    ),
                    Row(
                      children: [
                        _buildCircleIcon(Icons.remove, () => _decrementItem(title)),
                        SizedBox(width: 10),
                        Text("${itemCounts[title]}", style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(width: 10),
                        _buildCircleIcon(Icons.add, () => _incrementItem(title)),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Opacity(
                      opacity: 0.5,
                      child: Icon(
                        Icons.more_horiz,
                        size: 30,
                      ),
                    ),
                    Text("\$${(unitPrice * itemCounts[title]!).toStringAsFixed(2)}", style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCircleIcon(IconData iconData, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(child: Icon(iconData, color: Colors.black.withOpacity(0.75), size: 20)),
      ),
    );
  }
}
