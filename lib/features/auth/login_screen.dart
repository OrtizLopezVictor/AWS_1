import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../state/providers.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _userFocus = FocusNode();
  final _passFocus = FocusNode();

  bool _loading = false;
  bool _obscure = true;
  @override
  void dispose() {
    _userCtrl.dispose();
    _passCtrl.dispose();
    _userFocus.dispose();
    _passFocus.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    setState(() => _loading = true);

    try {
      final ok = await ref.read(authRepositoryProvider).login(
            _userCtrl.text.trim(),
            _passCtrl.text,
          );
      if (!mounted) return;
      if (ok) {
        context.go('/');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Credenciales inválidas o usuario inactivo')),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al iniciar sesión: $e')),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _forgotPassword() async {
    final c = TextEditingController(text: _userCtrl.text.trim());
    final user = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Recuperar contraseña'),
        content: TextField(
          controller: c,
          decoration: const InputDecoration(
            labelText: 'Usuario o correo',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.pop(ctx, c.text.trim()), child: const Text('Enviar')),
        ],
      ),
    );
    if (user == null || user.isEmpty) return;

    try {
      await ref.read(authRepositoryProvider).forgotPassword(user);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Correo de recuperación enviado (si existe)')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo enviar la recuperación: $e')),
      );
    }
  }

  Future<void> _switchAccount() async {
    try {
      await ref.read(authRepositoryProvider).switchAccount();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cuenta cambiada. Inicia sesión de nuevo.')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo cambiar de cuenta: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Acceso')),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (kDebugMode)
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          // ignore: deprecated_member_use
                          color: Colors.amber.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Modo DEV: usa demo / 1234',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: _userCtrl,
                                focusNode: _userFocus,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  labelText: 'Usuario',
                                  prefixIcon: Icon(Icons.person_outline),
                                  border: OutlineInputBorder(),
                                ),
                                validator: (v) =>
                                    (v == null || v.trim().isEmpty) ? 'Ingresa tu usuario' : null,
                                onFieldSubmitted: (_) => _passFocus.requestFocus(),
                              ),
                              const SizedBox(height: 12),
                              TextFormField(
                                controller: _passCtrl,
                                focusNode: _passFocus,
                                obscureText: _obscure,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  labelText: 'Contraseña',
                                  prefixIcon: const Icon(Icons.lock_outline),
                                  border: const OutlineInputBorder(),
                                  suffixIcon: IconButton(
                                    icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                                    onPressed: () => setState(() => _obscure = !_obscure),
                                  ),
                                ),
                                validator: (v) =>
                                    (v == null || v.isEmpty) ? 'Ingresa tu contraseña' : null,
                                onFieldSubmitted: (_) => _submit(),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: FilledButton.icon(
                                  onPressed: _loading ? null : _submit,
                                  icon: _loading
                                      ? const SizedBox(
                                          width: 18, height: 18,
                                          child: CircularProgressIndicator(strokeWidth: 2),
                                        )
                                      : const Icon(Icons.login),
                                  label: Text(_loading ? 'Ingresando...' : 'Entrar'),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                alignment: WrapAlignment.spaceBetween,
                                children: [
                                  TextButton.icon(
                                    onPressed: _loading ? null : _forgotPassword,
                                    icon: const Icon(Icons.help_outline),
                                    label: const Text('¿Olvidaste tu contraseña?'),
                                  ),
                                  TextButton.icon(
                                    onPressed: _loading ? null : _switchAccount,
                                    icon: const Icon(Icons.switch_account),
                                    label: const Text('Cambiar cuenta'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
