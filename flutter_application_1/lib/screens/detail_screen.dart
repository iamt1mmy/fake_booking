import 'package:flutter/material.dart';
import '../models/destination.dart';

/// Ecranul care afișează detaliile pentru o `Destination`.
/// Folosește un `CustomScrollView` cu `SliverAppBar` pentru a oferi un header expandabil cu imaginea destinației și un conținut scrollabil dedesubt.
class DetailScreen extends StatelessWidget {
  /// Destinația afișată pe acest ecran.
  final Destination destination;

  const DetailScreen({super.key, required this.destination});

  /// Construiește ecranul de detalii, incluzând un `SliverAppBar` cu imaginea și o secțiune de descriere cu un buton de rezervare (simulat).
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              // Titlul este afișat peste imagine; se folosesc umbre pentru lizibilitate când imaginea e deschisă la culoare.
              title: Text(destination.title,
                  style: const TextStyle(
                      color: Colors.white,
                      shadows: [Shadow(color: Colors.black, blurRadius: 10)])),
              background: Image.network(
                destination.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_city, color: Colors.blue),
                      const SizedBox(width: 10),
                      Text(
                        destination.location,
                        style: const TextStyle(fontSize: 18, color: Colors.black54),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Descriere",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    destination.description,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Simulăm o rezervare afișând un SnackBar.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Rezervare simulată cu succes!')),
                        );
                      },
                      icon: const Icon(Icons.bookmark_add),
                      label: const Text("Rezervă Acum"),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
