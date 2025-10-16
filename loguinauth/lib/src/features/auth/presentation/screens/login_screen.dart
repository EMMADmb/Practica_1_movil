import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/login_cubit.dart';
import '../../application/login_state.dart'; 

// --- LoginScreen: Provee el Cubit ---
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: const LoginForm(), 
      ),
    );
  }
}

// --- LoginForm: Maneja el Estado Local y Llama a los Componentes ---
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>(); 
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordObscured = true; 

  // Control de Foco (Desafío 1)
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
  );

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Función de envío con la corrección de .trim()
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _emailFocusNode.unfocus();
      _passwordFocusNode.unfocus();
      
      // CORRECCIÓN CLAVE: Usamos .trim() para asegurar que la validación sea exacta
      context.read<LoginCubit>().login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // BlocListener para feedback (Desafío 3)
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage), backgroundColor: Colors.red),
          );
        } else if (state is LoginSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login successful! Welcome.'), backgroundColor: Colors.green),
          );
        }
      },
      child: SingleChildScrollView( 
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const LoginLogo(), 
            
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Componente de Email
                  LoginEmailField(
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                    nextFocusNode: _passwordFocusNode,
                    emailRegExp: _emailRegExp,
                  ),
                  const SizedBox(height: 16),
                  
                  // Componente de Contraseña
                  LoginPasswordField(
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    isPasswordObscured: _isPasswordObscured,
                    toggleObscureText: () => setState(() => _isPasswordObscured = !_isPasswordObscured),
                    onSubmitted: _submitForm,
                  ),
                  const SizedBox(height: 16),

                  // Checkbox
                  const RememberMeCheckbox(),
                  const SizedBox(height: 24),

                  // Botón
                  LoginSubmitButton(onSubmit: _submitForm),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =======================================================
// --- COMPONENTES EXTRAÍDOS (Desafío 4) ---
// =======================================================

class LoginLogo extends StatelessWidget {
  const LoginLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 300,
      child: Image.asset('assets/images/logo_app.png'),
    );
  }
}

class LoginEmailField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final RegExp emailRegExp;

  const LoginEmailField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.nextFocusNode,
    required this.emailRegExp,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      decoration: const InputDecoration(
        labelText: 'Email Address',
      ),
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(nextFocusNode),
      validator: (value) {
        if (value == null || !emailRegExp.hasMatch(value)) { 
          return 'Please enter a valid email address';
        }
        return null;
      },
    );
  }
}

class LoginPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isPasswordObscured;
  final VoidCallback toggleObscureText;
  final VoidCallback onSubmitted;

  const LoginPasswordField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.isPasswordObscured,
    required this.toggleObscureText,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: isPasswordObscured, 
      decoration: InputDecoration(
        labelText: 'Password',
        suffixIcon: IconButton(
          icon: Icon(
            isPasswordObscured ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: toggleObscureText,
        ),
      ),
      textInputAction: TextInputAction.done, 
      onFieldSubmitted: (_) => onSubmitted(),
      validator: (value) {
        if (value == null || value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
    );
  }
}

class RememberMeCheckbox extends StatelessWidget {
  const RememberMeCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.isRememberMeChecked != current.isRememberMeChecked,
      builder: (context, state) {
        return CheckboxListTile(
          title: const Text('Remember Me'),
          value: state.isRememberMeChecked, 
          onChanged: (newValue) {
            context.read<LoginCubit>().toggleRememberMe(newValue ?? false);
          },
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
        );
      },
    );
  }
}

class LoginSubmitButton extends StatelessWidget {
  final VoidCallback onSubmit;

  const LoginSubmitButton({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    // BlocBuilder para el indicador de carga (Desafío 3)
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => current is LoginLoading || previous is LoginLoading,
      builder: (context, state) {
        final bool isLoading = state is LoginLoading;
        
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
          onPressed: isLoading ? null : onSubmit, 
          child: isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                )
              : const Text('Login'),
        );
      },
    );
  }
}