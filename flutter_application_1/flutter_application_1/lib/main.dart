import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: 5.0),
            Image.asset(
              "assets/images/11.png",
              width: 60,
              height: 60,
            ),
            SizedBox(width: 5.0),
            Text(
              'ATİK TİCARET',
              style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
            ),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 242, 0, 0),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  hintText: 'Kullanıcı Adi',
                  hintStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Şifre',
                  hintStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 255, 0, 0)),
                onPressed: () {
                  String username = _usernameController.text;
                  String password = _passwordController.text;

                  if (username.isEmpty || password.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Lütfen Şifre ve Kullanıcı Adını Giriniz. '),
                      ),
                    );
                    return;
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Giriş Başarılı'),
                      ),
                    );
                  }
                  // Navigator ile ikinci sayfaya geçiş
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShoppingScreen(
                        username: username,
                        password: password,
                      ),
                    ),
                  );
                },
                child: Text('Login', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Product {
  String image;
  String name;
  double price;

  Product(
    this.image,
    this.name,
    this.price,
  );
}

class ShoppingScreen extends StatelessWidget {
  final String username;
  final String password;
  final List<Product> selectedProducts = [];

  final List<Product> products = [
    Product('assets/images/anakin.jpg', 'Anakin Skywalker', 100),
    Product('assets/images/obiwan.jpg', 'Obi Wan Kenobi', 94),
    Product('assets/images/yoda.png', 'Usta Yoda', 105),
    Product('assets/images/vader.jpg', 'Darth Vader', 107),
    Product('assets/images/maul.jpg', 'Darth Maul', 89),
    Product('assets/images/mandalore.jpg', 'Mandalore', 85),
  ];

  ShoppingScreen({required this.username, required this.password});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: 5.0),
            Image.asset(
              "assets/images/11.png",
              width: 60,
              height: 60,
            ),
            const SizedBox(
              width: 20.0,
            ),
            Text(
              'Hoşgeldiniz \n$username',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 242, 0, 0),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.asset(
              products[index].image,
              width: 50,
              height: 50,
            ),
            title: Text(products[index].name,
                style: const TextStyle(color: Colors.white)),
            subtitle: Text('\$${products[index].price.toStringAsFixed(2)}',
                style: const TextStyle(color: Colors.white)),
            trailing: IconButton(
              icon: const Icon(Icons.add_shopping_cart, color: Colors.white),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Ürün Eklendi.'),
                    duration: Duration(seconds: 2),
                  ),
                );
                selectedProducts.add(products[index]);
              },
            ),
          );
        },
      ),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 17, 17, 17),
        child: Container(
          color: const Color.fromARGB(255, 17, 17, 17),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 242, 0, 0),
                ),
                child: Text(
                  'Menu ',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                title: const Text(
                  'Sepet',
                  style: TextStyle(color: Colors.white),
                ),
                leading: const Icon(Icons.shopping_cart, color: Colors.white),
                onTap: () {
                  // Navigate to CartScreen and pass selectedProducts
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(selectedProducts),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text(
                  'Çıkışş',
                  style: TextStyle(color: Colors.white),
                ),
                leading: const Icon(Icons.exit_to_app, color: Colors.white),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 17, 17, 17),
    );
  }
}

class CartScreen extends StatelessWidget {
  final List<Product> selectedProducts;

  CartScreen(this.selectedProducts);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 242, 0, 0),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Ürün', style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        itemCount: selectedProducts.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.asset(
              selectedProducts[index].image,
              width: 50,
              height: 50,
            ),
            title: Text(selectedProducts[index].name,
                style: TextStyle(color: Colors.white)),
            subtitle: Text(
                '\$${selectedProducts[index].price.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.white)),
            trailing: IconButton(
              icon: Icon(Icons.remove_shopping_cart, color: Colors.white),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Ürün eklendi.'),
                    duration: Duration(seconds: 2),
                  ),
                );
                selectedProducts.remove(selectedProducts[index]);
              },
            ),
          );
        },
      ),
      drawer: Drawer(
        child: Container(
          color: const Color.fromARGB(255, 17, 17, 17),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 242, 0, 0),
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                title: const Text('Alışveriş Ekranı',
                    style: TextStyle(color: Colors.white)),
                leading:
                    Icon(Icons.shopping_cart_outlined, color: Colors.white),
                onTap: () {
                  Navigator.pop(context); // Close the Drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShoppingScreen(
                        username: '', // Provide the required information
                        password: '', // Provide the required information
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text(
                  'Exit',
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(Icons.exit_to_app, color: Colors.white),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 17, 17, 17),
    );
  }
}
