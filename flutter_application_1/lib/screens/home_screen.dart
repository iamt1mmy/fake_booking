import 'package:flutter/material.dart';
import '../data/destinations_data.dart';
import '../models/destination.dart';
import '../widgets/destination_card.dart';

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
  bool _sortDesc = true;

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

    results.sort((a, b) => _sortDesc
        ? b.rating.compareTo(a.rating)
        : a.rating.compareTo(b.rating));
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
                const Text('Sortează după rating'),
                const SizedBox(width: 8),
                IconButton(
                  tooltip: _sortDesc ? 'Descrescător' : 'Crescător',
                  icon: Icon(
                    _sortDesc ? Icons.arrow_downward : Icons.arrow_upward,
                  ),
                  onPressed: () => setState(() => _sortDesc = !_sortDesc),
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
