/*import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

// 1. PONTO DE ENTRADA DO POPUP (Isolado)
@pragma("vm:entry-point")
void overlayMain() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Material(
        color: Colors.transparent,
        child: Center(child: OverlayWidget()),
      ),
    ),
  );
}

// Widget que aparecerá no Popup
class OverlayWidget extends StatelessWidget {
  const OverlayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Popup Ativo! Teste de texto\n"
            "mais teste",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => FlutterOverlayWindow.closeOverlay(),
            child: const Text("Fechar"),
          ),
        ],
      ),
    );
  }
}

// 2. PONTO DE ENTRADA DO APP PRINCIPAL
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isOverlayActive = false;

  @override
  void initState() {
    super.initState();
    _checkStatus();
  }

  // Verifica se o overlay já está aberto
  Future<void> _checkStatus() async {
    final bool isActive = await FlutterOverlayWindow.isActive();
    setState(() {
      _isOverlayActive = isActive;
    });
  }

  // Função para ligar/desligar o overlay via Switch
  Future<void> _toggleOverlay(bool value) async {
    if (value) {
      // Verifica e solicita permissão de "Sobrepor a outros apps"
      final bool status = await FlutterOverlayWindow.isPermissionGranted();
      if (!status) {
        await FlutterOverlayWindow.requestPermission();
        return; // O usuário precisará clicar novamente após conceder
      }

      // Mostra o overlay
      await FlutterOverlayWindow.showOverlay(
        enableDrag: true,
        overlayTitle: "Serviço de Popup Ativo",
        overlayContent: "O popup continuará visível",
        flag: OverlayFlag.defaultFlag,
        visibility: NotificationVisibility.visibilityPublic,
        height: WindowSize.matchParent,
        width: WindowSize.matchParent,
      );
    } else {
      // Fecha o overlay
      await FlutterOverlayWindow.closeOverlay();
    }
    setState(() {
      _isOverlayActive = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Controle de Popup")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isOverlayActive ? "Popup está ATIVADO" : "Popup está DESATIVADO",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Switch(value: _isOverlayActive, onChanged: _toggleOverlay),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Teste: Ative o switch e feche o aplicativo (remova dos recentes). "
                "O popup deve permanecer na tela.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
/**
 * configuração com o overlay deslignado o switch
 */
///library;

/*
import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

// --- PONTO DE ENTRADA DO POPUP ---
@pragma("vm:entry-point")
void overlayMain() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Material(color: Colors.transparent, child: OverlayWidget()),
    ),
  );
}

class OverlayWidget extends StatelessWidget {
  const OverlayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Popup Ativo!\n"
            "o senhor é meu pastor e nada me\n"
            "faltará",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              // Antes de fechar, avisamos o App principal para desmarcar o Switch
              //await FlutterOverlayWindow.shareData("closed_by_user");
              await FlutterOverlayWindow.closeOverlay();
            },
            child: const Text("Fechar"),
          ),
        ],
      ),
    );
  }
}

// --- APP PRINCIPAL ---
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isOverlayActive = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadSwitchState();
    _listenToOverlay();
  }

  // Escuta se o popup foi fechado por dentro dele mesmo
  void _listenToOverlay() {
    FlutterOverlayWindow.overlayListener.listen((event) {
      if (event == "closed_by_user") {
        setState(() => _isOverlayActive = false);
        _saveSwitchState(false);
      }
    });
  }

  // Carrega o estado salvo no celular
  Future<void> _loadSwitchState() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isActive = await FlutterOverlayWindow.isActive();

    setState(() {
      // Sincroniza o estado visual com a realidade do processo
      _isOverlayActive = prefs.getBool('overlay_enabled') ?? false;
      if (!isActive) _isOverlayActive = false;
    });
  }

  // Salva o estado do Switch
  Future<void> _saveSwitchState(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('overlay_enabled', value);
  }

  Future<void> _toggleOverlay(bool value) async {
    if (value) {
      // 1. Verificar permissão de Sobreposição
      final bool status = await FlutterOverlayWindow.isPermissionGranted();
      if (!status) {
        await FlutterOverlayWindow.requestPermission();
        return;
      }

      // 2. Verificar permissão de Notificação (Obrigatório para FGS no Android 13+)
      var notificationStatus = await Permission.notification.status;
      if (notificationStatus.isDenied) {
        notificationStatus = await Permission.notification.request();
      }

      if (notificationStatus.isGranted) {
        try {
          await FlutterOverlayWindow.showOverlay(
            enableDrag: true,
            overlayTitle: "Serviço Ativo",
            overlayContent: "O popup está rodando",
            height: 500, // Tente usar valores fixos primeiro
            width: 500,
            alignment: OverlayAlignment.center,
            visibility: NotificationVisibility.visibilityPublic,
            flag: OverlayFlag.defaultFlag,
          );
        } catch (e) {
          print("Erro: $e");
        }
      }
    } else {
      await FlutterOverlayWindow.closeOverlay();
    }

    setState(() => _isOverlayActive = value);
    _saveSwitchState(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Controle de Popup")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _isOverlayActive ? Icons.visibility : Icons.visibility_off,
              size: 80,
              color: _isOverlayActive ? Colors.green : Colors.grey,
            ),
            const SizedBox(height: 20),
            Text(
              _isOverlayActive
                  ? "O Popup está ATIVO"
                  : "O Popup está DESATIVADO",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Switch(
              value: _isOverlayActive,
              onChanged: _toggleOverlay,
              activeThumbColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
*/

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:permission_handler/permission_handler.dart';

// --- PONTO DE ENTRADA DO POPUP (Isolado) ---
@pragma("vm:entry-point")
void overlayMain() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Material(color: Colors.transparent, child: OverlayWidget()),
    ),
  );
}

class OverlayWidget extends StatefulWidget {
  const OverlayWidget({super.key});

  @override
  State<OverlayWidget> createState() => _OverlayWidgetState();
}

class _OverlayWidgetState extends State<OverlayWidget> {
  bool _isVisible = true;

  void _startWaitingCycle() async {
    setState(() => _isVisible = false);

    // 1. "Esconde" o popup reduzindo para 1x1.
    // O terceiro argumento 'true' mantém a capacidade de arrastar se necessário.
    await FlutterOverlayWindow.resizeOverlay(1, 1, true);

    // 2. Aguarda os 10 segundos
    Timer(const Duration(seconds: 10), () async {
      // 3. Volta ao tamanho original
      await FlutterOverlayWindow.resizeOverlay(270, 270, true);
      setState(() => _isVisible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Se estiver no modo "escondido", retornamos quase nada
    if (!_isVisible) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "TESTE EM SEGUNDO PLANO",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          const SizedBox(height: 10),
          const Text(
            "O Senhor é meu pastor e nada me faltará.",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade50,
            ),
            onPressed: _startWaitingCycle,
            child: const Text("Fechar (Volta em 10s)"),
          ),
        ],
      ),
    );
  }
}

// --- APP PRINCIPAL ---
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(home: HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _switchValue = false;

  @override
  void initState() {
    super.initState();
    _checkStatus();
  }

  Future<void> _checkStatus() async {
    bool active = await FlutterOverlayWindow.isActive();
    setState(() => _switchValue = active);
  }

  Future<void> _toggleSwitch(bool value) async {
    if (value) {
      if (!await FlutterOverlayWindow.isPermissionGranted()) {
        await FlutterOverlayWindow.requestPermission();
        return;
      }
      if (await Permission.notification.isDenied) {
        await Permission.notification.request();
      }

      await FlutterOverlayWindow.showOverlay(
        enableDrag: true,
        overlayTitle: "Serviço de Teste",
        overlayContent: "O popup está ativo",
        height: 500,
        width: 500,
        alignment: OverlayAlignment.center,
        visibility: NotificationVisibility.visibilityPublic,
      );
    } else {
      await FlutterOverlayWindow.closeOverlay();
    }
    setState(() => _switchValue = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Popup Background Test")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _switchValue ? Icons.bolt : Icons.power_settings_new,
              size: 80,
              color: _switchValue ? Colors.green : Colors.grey,
            ),
            const SizedBox(height: 20),
            const Text("Ativar Popup Persistente:"),
            Switch(value: _switchValue, onChanged: _toggleSwitch),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Text(
                _switchValue
                    ? "O popup está ativo. Você pode fechar o aplicativo agora."
                    : "Ligue o switch para iniciar o teste.",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.blueGrey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
