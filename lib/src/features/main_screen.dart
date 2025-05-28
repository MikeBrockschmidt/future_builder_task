import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _zipController = TextEditingController();
  Future<String>? _cityFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _zipController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Postleitzahl",
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    _cityFuture = getCityFromZip(_zipController.text);
                  });
                },
                child: const Text("Suche"),
              ),
              const SizedBox(height: 16),
              _cityFuture == null
                  ? Text(
                      "Ergebnis: Noch keine PLZ gesucht",
                      style: Theme.of(context).textTheme.labelLarge,
                    )
                  : FutureBuilder<String>(
                      future: _cityFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text(
                            'Fehler: ${snapshot.error}',
                            style: TextStyle(color: Colors.red),
                          );
                        } else if (snapshot.hasData) {
                          return Text(
                            "Ergebnis: ${snapshot.data}",
                            style: Theme.of(context).textTheme.labelLarge,
                          );
                        } else {
                          return const Text("Unbekannter Zustand");
                        }
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _zipController.dispose();
    super.dispose();
  }

  Future<String> getCityFromZip(String zip) async {
    await Future.delayed(const Duration(seconds: 3));
    switch (zip) {
      case "49170":
        return 'Hagen a.T.W.';
      case "53225":
        return 'Bonn Beuel';
      case "53773":
        return 'Hennef (Sieg)';
      case "49086":
        return 'Osnabrück Lüstringen';
      case "49074":
        return 'Osnabrück Lüstringen';
      case "60313":
        return 'Frankfurt am Main';
      case "10115":
        return 'Berlin';
      case "20095":
        return 'Hamburg';
      case "80331":
        return 'München';
      case "50667":
        return 'Köln';
      default:
        return 'Unbekannte Stadt';
    }
  }
}
