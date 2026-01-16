/// Model simplu care reprezintă o destinație turistică.
/// Conține titlu, locație, descriere, url pentru imagine și rating.
class Destination {
  /// Titlul destinației (ex: 'Castelul Peleș').
  final String title;

  /// Locația (ex: 'Sinaia, România').
  final String location;

  /// Descriere detaliată a destinației.
  final String description;

  /// URL către imaginea reprezentativă.
  /// Observație: imaginile provin din surse externe, deci încărcarea poate eșua dacă URL-ul nu mai este valid. Tratarea erorilor se face în UI.
  final String imageUrl;

  /// Rating numeric (ex: 4.8).
  final double rating;

  /// Constructor pentru `Destination`.
  Destination({
    required this.title,
    required this.location,
    required this.description,
    required this.imageUrl,
    required this.rating,
  });
}
