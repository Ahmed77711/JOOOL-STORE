import 'package:flutter/material.dart';

void main() {
  runApp(const ShadowStoreApp());
}

class ShadowStoreApp extends StatelessWidget {
  const ShadowStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SHADOW STORE',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF090D16),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF3B82F6),
          surface: Color(0xFF111827),
        ),
      ),
      home: const ShadowStoreHomeScreen(),
    );
  }
}

class ShadowStoreHomeScreen extends StatelessWidget {
  const ShadowStoreHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SHADOW STORE',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2.0, color: Colors.blueAccent),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF111827),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.shopping_cart, color: Colors.white, size: 18),
                      label: const Text('شراء', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF10B981),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.sell, color: Colors.white, size: 18),
                      label: const Text('بيع', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B5CF6),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.task_alt, color: Colors.white, size: 18),
                      label: const Text('المهام', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3B82F6),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'قائمة الحسابات المتاحة',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            _buildAccountCard(
              context,
              title: 'الحساب البرونزي',
              price: '0.30 باي (Pi)',
              buttonText: 'شراء الحساب البرونزي',
              buttonColor: const Color(0xFF10B981),
            ),
            const SizedBox(height: 16),
            _buildAccountCard(
              context,
              title: 'الحساب الفضي',
              price: '1 دولار',
              buttonText: 'الدفع 1 دولار (رابط الدفع)',
              buttonColor: const Color(0xFF3B82F6),
            ),
            const SizedBox(height: 16),
            _buildAccountCard(
              context,
              title: 'الحساب الذهبي',
              price: '3 دولار',
              buttonText: 'الدفع 3 دولار (رابط الدفع)',
              buttonColor: const Color(0xFFF59E0B),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountCard(
    BuildContext context, {
    required String title,
    required String price,
    required String buttonText,
    required Color buttonColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            'السعر: $price',
            style: const TextStyle(fontSize: 16, color: Colors.amberAccent, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckoutScreen(accountTitle: title, price: price),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                buttonText,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CheckoutScreen extends StatefulWidget {
  final String accountTitle;
  final String price;

  const CheckoutScreen({super.key, required this.accountTitle, required this.price});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void _sendToTelegram() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _isLoading = false;
        });
        _showSuccessDialog('تم بنجاح، سوف يتم الدفع خلال ساعة');
      });
    }
  }

  void _showSuccessDialog(String text) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('تأكيد الطلب', style: TextStyle(color: Colors.green)),
        content: Text(text, style: const TextStyle(fontSize: 16)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              Navigator.pop(context);
            },
            child: const Text('حسناً', style: TextStyle(color: Colors.blueAccent)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('شراء ${widget.accountTitle}'),
        centerTitle: true,
        backgroundColor: const Color(0xFF111827),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'السعر المطلوب: ${widget.price}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.amberAccent,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'أدخل الإيميل',
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: const Color(0xFF111827),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.email, color: Color(0xFF3B82F6)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال الإيميل';
                  }
                  if (!value.contains('@') || !value.contains('.')) {
                    return 'الرجاء إدخال بريد إلكتروني صالح';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'أدخل كلمة السر',
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: const Color(0xFF111827),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.lock, color: Color(0xFF3B82F6)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال كلمة السر';
                  }
                  if (value.length < 6) {
                    return 'كلمة السر يجب أن تكون 6 أحرف على الأقل';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton.icon(
                      onPressed: _sendToTelegram,
                      icon: const Icon(Icons.send, color: Colors.white),
                      label: const Text('إرسال الطلب وإتمام الدفع', style: TextStyle(fontSize: 16, color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF10B981),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
