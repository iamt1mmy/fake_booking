import 'package:flutter/material.dart';
import '../data/destinations_data.dart';
import '../models/destination.dart';
import '../widgets/destination_card.dart';

/// Opțiuni de sortare disponibile pentru lista de destinații.
enum SortOption { none, ratingDesc, ratingAsc, nameAsc, nameDesc }

/// Ecranul principal care afișează lista de destinații.
/// Oferă funcționalități de căutare, filtrare și sortare, precum și un buton pentru comutarea temei (luminos/întunecat) primit din `MyApp`.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.isDarkMode, required this.onToggleTheme});

  /// Indică dacă tema curentă este dark.
  final bool isDarkMode;

  /// Callback apelat pentru a comuta tema.
  final ValueChanged<bool> onToggleTheme;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  SortOption _sortOption = SortOption.none;

  /// Returnează lista de destinații filtrată și sortată în funcție de stare.
  /// Filtrarea se face pe `title` și `location`. Sortarea aplică comparatoare diferite în funcție de `_sortOption`.
  List<Destination> get _filteredDestinations {
    List<Destination> results;
    if (_query.isEmpty) {
      // Folosim o copie pentru a nu modifica lista originală `destinations`.
      results = List<Destination>.from(destinations);
    } else {
      final lower = _query.toLowerCase();
      results = destinations.where((d) {
        return d.title.toLowerCase().contains(lower) ||
            d.location.toLowerCase().contains(lower);
      }).toList();
    }

    // Aplicăm sortarea pe copia `results`:
    switch (_sortOption) {
      case SortOption.ratingDesc:
        results.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case SortOption.ratingAsc:
        results.sort((a, b) => a.rating.compareTo(b.rating));
        break;
      case SortOption.nameAsc:
        results.sort((a, b) => a.title.compareTo(b.title));
        break;
      case SortOption.nameDesc:
        results.sort((a, b) => b.title.compareTo(a.title));
        break;
      case SortOption.none:
        // păstrăm ordinea implicită a listei
        break;
    }
    return results;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Construiește interfața ecranului principal: bară de căutare, dropdown desortare și lista de `CustomDestinationCard`.
  @override
  Widget build(BuildContext context) {
    final filtered = _filteredDestinations;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Destinații Populare'),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: widget.isDarkMode ? 'Mod luminos' : 'Mod întunecat',
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            // Trimitem callback-ul către `MyApp` pentru a comuta tema.
            onPressed: () => widget.onToggleTheme(!widget.isDarkMode),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              controller: _searchController,
              // Actualizăm `_query` la fiecare schimbare pentru a reactualiza UI.
              onChanged: (value) => setState(() => _query = value),
              decoration: InputDecoration(
                hintText: 'Caută destinații sau locații',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _query = '');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                const Text('Sortează:'),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButton<SortOption>(
                    isExpanded: true,
                    value: _sortOption,
                    onChanged: (v) => setState(() => _sortOption = v ?? SortOption.none),
                    items: const [
                      DropdownMenuItem(value: SortOption.none, child: Text('Implicit (bază de date)')),
                      DropdownMenuItem(value: SortOption.ratingDesc, child: Text('Rating ↓')),
                      DropdownMenuItem(value: SortOption.ratingAsc, child: Text('Rating ↑')),
                      DropdownMenuItem(value: SortOption.nameAsc, child: Text('Nume A→Z')),
                      DropdownMenuItem(value: SortOption.nameDesc, child: Text('Nume Z→A')),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: filtered.isEmpty
                ? const Center(
                    child: Text('Nicio destinație găsită'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final destination = filtered[index];
                      return CustomDestinationCard(destination: destination);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
