import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_typography.dart';
import '../widgets/auth_header.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';

/// Screen 2: Halaman Register (Daftar Akun)
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _agreeTerms = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() async {
    if (!_agreeTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Silakan setujui syarat dan ketentuan terlebih dahulu.',
            style: AppTypography.bodySmall.copyWith(color: Colors.white),
          ),
          backgroundColor: AppColors.warning,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulasi proses registrasi akun baru
      await Future.delayed(const Duration(milliseconds: 1200));

      if (!mounted) return;
      setState(() => _isLoading = false);

      // Dialog Notifikasi Berhasil & Redirect Langsung ke Login
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          backgroundColor: AppColors.surface,
          title: Row(
            children: [
              const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 28),
              const SizedBox(width: 10),
              Text(
                'Akun Dibuat!',
                style: AppTypography.headingSmall,
              ),
            ],
          ),
          content: Text(
            'Pendaftaran berhasil! Akun Anda siap digunakan. Silakan masuk dengan akun yang baru dibuat.',
            style: AppTypography.bodyMedium,
          ),
          actions: [
            PrimaryButton(
              text: 'Lanjut ke Login',
              height: 44,
              onPressed: () {
                Navigator.of(ctx).pop(); // Tutup dialog
                Navigator.of(context).pop(); // Kembali ke halaman Login
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Komponen Custom: Header Auth
                const AuthHeader(
                  icon: Icons.person_add_alt_1_rounded,
                  title: 'Buat Akun Baru ✨',
                  subtitle: 'Silakan isi data diri Anda untuk mendaftar akun.',
                ),

                const SizedBox(height: 28),

                // Komponen Custom: Input Nama Lengkap
                CustomTextField(
                  controller: _nameController,
                  label: 'Nama Lengkap',
                  hintText: 'John Doe',
                  prefixIcon: Icons.person_outline_rounded,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nama lengkap wajib diisi';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Komponen Custom: Input Email
                CustomTextField(
                  controller: _emailController,
                  label: 'Alamat Email',
                  hintText: 'nama@email.com',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Email wajib diisi';
                    }
                    if (!value.contains('@') || !value.contains('.')) {
                      return 'Format email tidak valid';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Komponen Custom: Input Kata Sandi
                CustomTextField(
                  controller: _passwordController,
                  label: 'Kata Sandi',
                  hintText: 'Minimal 6 karakter',
                  prefixIcon: Icons.lock_outline_rounded,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kata sandi wajib diisi';
                    }
                    if (value.length < 6) {
                      return 'Kata sandi minimal 6 karakter';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Komponen Custom: Konfirmasi Kata Sandi
                CustomTextField(
                  controller: _confirmPasswordController,
                  label: 'Konfirmasi Kata Sandi',
                  hintText: 'Ulangi kata sandi Anda',
                  prefixIcon: Icons.verified_user_outlined,
                  isPassword: true,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _handleRegister(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Konfirmasi kata sandi wajib diisi';
                    }
                    if (value != _passwordController.text) {
                      return 'Konfirmasi kata sandi tidak cocok';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Checkbox Terms & Conditions
                Row(
                  children: [
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: Checkbox(
                        value: _agreeTerms,
                        activeColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        onChanged: (val) {
                          setState(() => _agreeTerms = val ?? false);
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Saya menyetujui Syarat & Ketentuan serta Kebijakan Privasi yang berlaku.',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Komponen Custom: Primary Button (Daftar Akun)
                PrimaryButton(
                  text: 'Daftar Akun Sekarang',
                  isLoading: _isLoading,
                  icon: Icons.app_registration_rounded,
                  onPressed: _handleRegister,
                ),

                const SizedBox(height: 28),

                // Link kembali ke Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sudah punya akun? ',
                      style: AppTypography.bodyMedium,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        'Masuk di sini',
                        style: AppTypography.linkText.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
