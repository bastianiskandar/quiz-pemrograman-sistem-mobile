import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_typography.dart';
import '../widgets/auth_header.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/secondary_button.dart';

/// Screen 3: Halaman Lupa Kata Sandi (Forgot Password)
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _isSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleResetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulasi proses pengiriman email reset password
      await Future.delayed(const Duration(milliseconds: 1200));

      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _isSent = true;
      });
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
          child: _isSent ? _buildSuccessView() : _buildFormView(),
        ),
      ),
    );
  }

  /// Tampilan Form Input Email
  Widget _buildFormView() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Komponen Custom: Header Auth
          const AuthHeader(
            icon: Icons.lock_reset_rounded,
            title: 'Lupa Kata Sandi? 🔑',
            subtitle:
                'Jangan panik, masukkan email Anda yang terdaftar dan kami akan mengirimkan link reset.',
          ),

          const SizedBox(height: 32),

          // Komponen Custom: Input Email
          CustomTextField(
            controller: _emailController,
            label: 'Alamat Email Terdaftar',
            hintText: 'nama@email.com',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _handleResetPassword(),
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

          const SizedBox(height: 28),

          // Komponen Custom: Primary Button
          PrimaryButton(
            text: 'Kirim Link Pemulihan',
            isLoading: _isLoading,
            icon: Icons.send_rounded,
            onPressed: _handleResetPassword,
          ),

          const SizedBox(height: 16),

          // Komponen Custom: Secondary Button (Kembali ke Login)
          SecondaryButton(
            text: 'Kembali ke Halaman Masuk',
            icon: Icons.arrow_back_rounded,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  /// Tampilan State Berhasil Terkirim
  Widget _buildSuccessView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.success.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.mark_email_read_rounded,
            color: AppColors.success,
            size: 44,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Email Terkirim! 📬',
          style: AppTypography.headingLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          'Instruksi pemulihan kata sandi telah dikirim ke:\n${_emailController.text.trim()}',
          style: AppTypography.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          'Silakan periksa kotak masuk atau folder spam Anda.',
          style: AppTypography.bodySmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 36),

        // Tombol Kembali ke Login
        PrimaryButton(
          text: 'Kembali ke Login',
          icon: Icons.login_rounded,
          onPressed: () => Navigator.pop(context),
        ),

        const SizedBox(height: 16),

        TextButton(
          onPressed: () {
            setState(() {
              _isSent = false;
            });
          },
          child: Text(
            'Gunakan email lain',
            style: AppTypography.linkText,
          ),
        ),
      ],
    );
  }
}
