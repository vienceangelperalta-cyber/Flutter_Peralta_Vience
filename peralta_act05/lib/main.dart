import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const StudentFormApp());
}

class StudentFormApp extends StatelessWidget {
  const StudentFormApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Form',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const StudentFormPage(),
    );
  }
}

class StudentFormPage extends StatefulWidget {
  const StudentFormPage({super.key});

  @override
  State<StudentFormPage> createState() => _StudentFormPageState();
}

class _StudentFormPageState extends State<StudentFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController(
    text: 'Vience Angel P. Peralta',
  );
  final _courseController = TextEditingController(
    text: 'Bachelor Of Science and Information Technology',
  );
  final _ageController = TextEditingController(text: '21');
  final _addressController = TextEditingController(
    text: 'Bitan-o Dalipay, Sorsogon City',
  );
  final _contactController = TextEditingController(text: '09945623589');
  final _emailController = TextEditingController(
    text: 'vienceangelperalta@thelewiscollege.edu.ph',
  );

  @override
  void dispose() {
    _nameController.dispose();
    _courseController.dispose();
    _ageController.dispose();
    _addressController.dispose();
    _contactController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Student Profile Form'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${_nameController.text}'),
              const SizedBox(height: 8),
              Text('Course: ${_courseController.text}'),
              const SizedBox(height: 8),
              Text('Age: ${_ageController.text}'),
              const SizedBox(height: 8),
              Text('Address: ${_addressController.text}'),
              const SizedBox(height: 8),
              Text('Contact No: ${_contactController.text}'),
              const SizedBox(height: 8),
              Text('Email: ${_emailController.text}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _reset() {
    _nameController.clear();
    _courseController.clear();
    _ageController.clear();
    _addressController.clear();
    _contactController.clear();
    _emailController.clear();
    _formKey.currentState!.reset();
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String? Function(String?) validator,
    TextInputType? keyboardType,
    List<TextInputFormatter>? formatters,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: formatters,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
        validator: validator,
      ),
    );
  }

  String? _required(String? v, String msg) =>
      (v == null || v.trim().isEmpty) ? msg : null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Form'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.school, size: 56, color: Colors.indigo),
                      const SizedBox(height: 16),
                      Text(
                        'Student Information',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 24),
                      _field(
                        controller: _nameController,
                        label: 'Name',
                        icon: Icons.person,
                        validator: (v) => _required(v, 'Please enter your name'),
                      ),
                      _field(
                        controller: _courseController,
                        label: 'Course',
                        icon: Icons.menu_book,
                        validator: (v) => _required(v, 'Please enter your course'),
                      ),
                      _field(
                        controller: _ageController,
                        label: 'Age',
                        icon: Icons.cake,
                        keyboardType: TextInputType.number,
                        formatters: [FilteringTextInputFormatter.digitsOnly],
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Please enter your age';
                          }
                          final age = int.tryParse(v);
                          if (age == null || age <= 0 || age > 120) {
                            return 'Enter a valid age';
                          }
                          return null;
                        },
                      ),
                      _field(
                        controller: _addressController,
                        label: 'Address',
                        icon: Icons.home,
                        validator: (v) => _required(v, 'Please enter your address'),
                      ),
                      _field(
                        controller: _contactController,
                        label: 'Contact No.',
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                        formatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(11),
                        ],
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Please enter your contact number';
                          }
                          if (v.length != 11) {
                            return 'Contact number must be 11 digits';
                          }
                          return null;
                        },
                      ),
                      _field(
                        controller: _emailController,
                        label: 'Email',
                        icon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Please enter your email';
                          }
                          final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                              .hasMatch(v.trim());
                          return ok ? null : 'Enter a valid email address';
                        },
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _reset,
                              child: const Text('Clear'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: FilledButton(
                              onPressed: _submit,
                              child: const Text('Submit'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}