import 'package:flutter/material.dart';
import '../data/destinations_data.dart';
import '../models/destination.dart';
import '../widgets/destination_card.dart';

enum SortOption { none, ratingDesc, ratingAsc, nameAsc, nameDesc }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.isDarkMode, required this.onToggleTheme});

  final bool isDarkMode;
  final ValueChanged<bool> onToggleTheme;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  SortOption _sortOption = SortOption.none;

  List<Destination> get _filteredDestinations {
    List<Destination> results;
    if (_query.isEmpty) {
      results = List<Destination>.from(destinations);
    } else {
      final lower = _query.toLowerCase();
      results = destinations.where((d) {
        return d.title.toLowerCase().contains(lower) ||
            d.location.toLowerCase().contains(lower);
      }).toList();
    }

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
        // keep original order
        break;
    }
    return results;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
