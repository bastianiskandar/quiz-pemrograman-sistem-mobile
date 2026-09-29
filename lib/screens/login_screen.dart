import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_typography.dart';
import '../widgets/auth_header.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/social_auth_button.dart';
import 'forgot_password_screen.dart';
import 'home_screen.dart';
import 'register_screen.dart';

/// Screen 1: Halaman Login (Masuk)
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulasi proses autentikasi
      await Future.delayed(const Duration(milliseconds: 1200));

      if (!mounted) return;
      setState(() => _isLoading = false);

      // Navigasi ke Halaman Utama / Home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            userEmail: _emailController.text.trim().isNotEmpty
                ? _emailController.text.trim()
                : 'user@example.com',
          ),
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Selamat datang kembali!',
            style: AppTypography.bodyMedium.copyWith(color: Colors.white),
          ),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Komponen Custom: Header Auth
                const AuthHeader(
                  icon: Icons.fingerprint_rounded,
                  title: 'Selamat Datang! 👋',
                  subtitle: 'Masukkan email dan kata sandi untuk mengakses akun Anda.',
                ),

                const SizedBox(height: 32),

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

                const SizedBox(height: 18),

                // Komponen Custom: Input Kata Sandi
                CustomTextField(
                  controller: _passwordController,
                  label: 'Kata Sandi',
                  hintText: '••••••••',
                  prefixIcon: Icons.lock_outline_rounded,
                  isPassword: true,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _handleLogin(),
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

                const SizedBox(height: 12),

                // Opsi Remember Me & Forgot Password
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: Checkbox(
                            value: _rememberMe,
                            activeColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            onChanged: (val) {
                              setState(() => _rememberMe = val ?? false);
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Ingat saya',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPasswordScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Lupa Kata Sandi?',
                        style: AppTypography.linkText,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Komponen Custom: Primary Button (Masuk)
                PrimaryButton(
                  text: 'Masuk Sekarang',
                  isLoading: _isLoading,
                  icon: Icons.login_rounded,
                  onPressed: _handleLogin,
                ),

                const SizedBox(height: 24),

                // Divider "atau"
                Row(
                  children: [
                    const Expanded(child: Divider(color: AppColors.border)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'atau',
                        style: AppTypography.bodySmall,
                      ),
                    ),
                    const Expanded(child: Divider(color: AppColors.border)),
                  ],
                ),

                const SizedBox(height: 20),

                // Komponen Custom: Social Auth Button
                SocialAuthButton(
                  text: 'Masuk dengan Google',
                  icon: const Icon(Icons.g_mobiledata_rounded, size: 28, color: Colors.red),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Fitur login Google siap diintegrasikan.'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),

                const SizedBox(height: 32),

                // Navigasi ke Register Screen
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Belum punya akun? ',
                      style: AppTypography.bodyMedium,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Daftar di sini',
                        style: AppTypography.linkText.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
