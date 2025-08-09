import 'package:flutter/material.dart';

void main() {
  runApp(const DeliveryApp());
}

class DeliveryApp extends StatelessWidget {
  const DeliveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const HomeScreen(),
    );
  }
}

// -------------------- HOME SCREEN --------------------
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, dynamic>> items = const [
    {"name": "Pizza", "price": 8.99, "icon": Icons.local_pizza},
    {"name": "Burger", "price": 5.49, "icon": Icons.fastfood},
    {"name": "Coffee", "price": 3.99, "icon": Icons.coffee},
    {"name": "Pasta", "price": 7.50, "icon": Icons.ramen_dining},
    {"name": "Ice Cream", "price": 2.99, "icon": Icons.icecream},
    {"name": "Sandwich", "price": 4.25, "icon": Icons.lunch_dining},
  ];

  void _showOrderMessage(BuildContext context, String itemName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Your $itemName order has been placed!"),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery Menu'),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Icon(item["icon"], size: 40, color: Colors.blue),
              title: Text(item["name"],
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              subtitle: Text("\$${item["price"]}"),
              trailing: ElevatedButton(
                onPressed: () => _showOrderMessage(context, item["name"]),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text("Order"),
              ),
            ),
          );
        },
      ),
    );
  }
}

// -------------------- NAVIGATION DRAWER --------------------
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text("FoodieFastTrack"),
            accountEmail: const Text("foodie@example.com"),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage("assets/profile.jpg"), // Add your image in assets
            ),
            decoration: const BoxDecoration(color: Colors.green),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: const Text("Orders"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OrdersScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_mail),
            title: const Text("Contact Us"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ContactScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

// -------------------- ORDERS SCREEN --------------------
class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Orders")),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text("No orders yet!", style: TextStyle(fontSize: 18)),
      ),
    );
  }
}

// -------------------- CONTACT SCREEN --------------------
class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Message sent!")),
      );
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contact Us")),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Name"),
                validator: (value) =>
                value!.isEmpty ? "Please enter your name" : null,
              ),

              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) =>
                value!.isEmpty ? "Please enter your email" : null,
              ),

              TextFormField(
                controller: _messageController,
                decoration: const InputDecoration(labelText: "Message"),
                maxLines: 4,
                validator: (value) =>
                value!.isEmpty ? "Please enter a message" : null,
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _sendMessage,
                style:
                ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: const Text("Send"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
