import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'hymn.dart';

// See: https://www.algolia.com/doc/guides/building-search-ui/getting-started/flutter/

class SearchMetadata {
  final int hits;
  final List<Hymn> hymns;

  const SearchMetadata(this.hits, this.hymns);

  factory SearchMetadata.fromResponse(SearchResponse response) {
    var hits = response.nbHits;
    var hymns = response.hits.map((hit) => Hymn.fromJson(hit)).toList();
    return SearchMetadata(hits, hymns);
  }
}
