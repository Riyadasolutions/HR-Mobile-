import 'package:base_app/base/domain/entities/drop_down_entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class Airport {
  final int id;
  final String name;
  final String city;
  final String country;
  final String? iata;
  final String? icao;
  final double latitude;
  final double longitude;

  Airport({
    required this.id,
    required this.name,
    required this.city,
    required this.country,
    this.iata,
    this.icao,
    required this.latitude,
    required this.longitude,
  });

  DropDownEntity toDropDownEntity() {
    // Create a display title with airport name, city, and IATA code if available
    String displayTitle = name;
    if (iata != null && iata!.isNotEmpty && iata != '\\N') {
      displayTitle = '$name ($iata)';
    } else if (icao != null && icao!.isNotEmpty && icao != '\\N') {
      displayTitle = '$name ($icao)';
    }
    
    return DropDownEntity(
      id: id,
      title: displayTitle,
      key: iata ?? icao ?? name,
      value: {
        'name': name,
        'city': city,
        'country': country,
        'iata': iata,
        'icao': icao,
        'latitude': latitude,
        'longitude': longitude,
      },
    );
  }
}

class AirportsDataService {
  static const String _airportsDataUrl = 
      'https://raw.githubusercontent.com/jpatokal/openflights/master/data/airports.dat';
  
  static List<Airport>? _cachedAirports;
  
  /// Fetches and parses airports data from the URL
  static Future<List<Airport>> fetchAirports() async {
    if (_cachedAirports != null) {
      return _cachedAirports!;
    }

    try {
      final dio = Dio();
      final response = await dio.get(_airportsDataUrl);
      
      if (response.statusCode == 200) {
        final String data = response.data;
        _cachedAirports = _parseAirportsData(data);
        return _cachedAirports!;
      } else {
        throw Exception('Failed to load airports data: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching airports data: $e');
      rethrow;
    }
  }

  /// Parses the CSV data from airports.dat
  static List<Airport> _parseAirportsData(String data) {
    final List<Airport> airports = [];
    final lines = data.split('\n');
    
    for (final line in lines) {
      if (line.trim().isEmpty) continue;
      
      try {
        final airport = _parseAirportLine(line);
        if (airport != null) {
          airports.add(airport);
        }
      } catch (e) {
        debugPrint('Error parsing airport line: $line, Error: $e');
        continue;
      }
    }
    
    return airports;
  }

  /// Parses a single line from airports.dat
  /// Format: id,"name","city","country","IATA","ICAO",latitude,longitude,altitude,timezone,dst,tz,type,source
  static Airport? _parseAirportLine(String line) {
    try {
      // Handle CSV parsing with quoted fields
      final List<String> fields = [];
      String currentField = '';
      bool inQuotes = false;
      
      for (int i = 0; i < line.length; i++) {
        final char = line[i];
        
        if (char == '"') {
          inQuotes = !inQuotes;
        } else if (char == ',' && !inQuotes) {
          fields.add(currentField);
          currentField = '';
        } else {
          currentField += char;
        }
      }
      fields.add(currentField); // Add last field
      
      if (fields.length < 14) {
        return null;
      }
      
      final id = int.tryParse(fields[0].trim()) ?? 0;
      if (id == 0) return null;
      
      final name = _cleanField(fields[1]);
      final city = _cleanField(fields[2]);
      final country = _cleanField(fields[3]);
      final iata = _cleanField(fields[4]);
      final icao = _cleanField(fields[5]);
      final latitude = double.tryParse(fields[6].trim()) ?? 0.0;
      final longitude = double.tryParse(fields[7].trim()) ?? 0.0;
      
      return Airport(
        id: id,
        name: name,
        city: city,
        country: country,
        iata: (iata == '\\N' || iata.isEmpty) ? null : iata,
        icao: (icao == '\\N' || icao.isEmpty) ? null : icao,
        latitude: latitude,
        longitude: longitude,
      );
    } catch (e) {
      debugPrint('Error parsing airport line: $e');
      return null;
    }
  }

  /// Cleans a CSV field (removes quotes and handles \N)
  static String _cleanField(String field) {
    String cleaned = field.trim();
    if (cleaned.startsWith('"') && cleaned.endsWith('"')) {
      cleaned = cleaned.substring(1, cleaned.length - 1);
    }
    if (cleaned == '\\N') {
      return '';
    }
    return cleaned;
  }

  /// Gets airports filtered by country name
  static Future<List<DropDownEntity>> getAirportsByCountry(String countryName) async {
    final airports = await fetchAirports();
    final filtered = airports
        .where((airport) => airport.country.toLowerCase() == countryName.toLowerCase())
        .toList();
    
    return filtered.map((airport) => airport.toDropDownEntity()).toList();
  }

  /// Clears the cache (useful for testing or refreshing data)
  static void clearCache() {
    _cachedAirports = null;
  }
}
