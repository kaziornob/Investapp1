class Listings {
  List<CryptoCoinDetail> data;

  Listings({this.data});
  Listings.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<CryptoCoinDetail>();
      json['data'].forEach((v) {
        data.add(new CryptoCoinDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CryptoCoinDetail {
  int id;
  String name;
  String symbol;
  String slug;
  int numMarketPairs;
  String dateAdded;
  List<String> tags;
  double maxSupply;
  double circulatingSupply;
  double totalSupply;
  int cmcRank;
  String lastUpdated;
  Quote quote;

  CryptoCoinDetail(
      {this.id,
      this.name,
      this.symbol,
      this.slug,
      this.numMarketPairs,
      this.dateAdded,
      this.tags,
      this.maxSupply,
      this.circulatingSupply,
      this.totalSupply,
      this.cmcRank,
      this.lastUpdated,
      this.quote});

  CryptoCoinDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    symbol = json['symbol'];
    slug = json['slug'];
    numMarketPairs = json['num_market_pairs'];
    dateAdded = json['date_added'];
    tags = json['tags'].cast<String>();
    maxSupply = double.tryParse('${json['maxSupply']}') ?? 0.0;
    circulatingSupply = double.tryParse('${json['circulatingSupply']}') ?? 0.0;
    totalSupply = double.tryParse('${json['totalSupply']}') ?? 0.0;
    cmcRank = json['cmc_rank'];
    lastUpdated = json['last_updated'];
    quote = json['quote'] != null ? new Quote.fromJson(json['quote']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    data['slug'] = this.slug;
    data['num_market_pairs'] = this.numMarketPairs;
    data['date_added'] = this.dateAdded;
    data['tags'] = this.tags;
    data['max_supply'] = this.maxSupply;
    data['circulating_supply'] = this.circulatingSupply;
    data['total_supply'] = this.totalSupply;
    data['cmc_rank'] = this.cmcRank;
    data['last_updated'] = this.lastUpdated;
    if (this.quote != null) {
      data['quote'] = this.quote.toJson();
    }
    return data;
  }
}

class Quote {
  USD uSD;

  Quote({this.uSD});

  Quote.fromJson(Map<String, dynamic> json) {
    uSD = json['USD'] != null ? new USD.fromJson(json['USD']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.uSD != null) {
      data['USD'] = this.uSD.toJson();
    }
    return data;
  }
}

class USD {
  double price;
  double volume24h;
  double percentChange1h;
  double percentChange24h;
  double percentChange7d;
  double marketCap;
  String lastUpdated;

  USD({this.price, this.volume24h, this.percentChange1h, this.percentChange24h, this.percentChange7d, this.marketCap, this.lastUpdated});

  USD.fromJson(Map<String, dynamic> json) {
    price = double.tryParse('${json['price']}') ?? 0.0;
    volume24h = double.tryParse('${json['volume24h']}') ?? 0.0;
    percentChange1h = double.tryParse('${json['percentChange1h']}') ?? 0.0;
    percentChange24h = double.tryParse('${json['percentChange24h']}') ?? 0.0;
    percentChange7d = double.tryParse('${json['percentChange7d']}') ?? 0.0;
    marketCap = double.tryParse('${json['marketCap']}') ?? 0.0;
  
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['volume_24h'] = this.volume24h;
    data['percent_change_1h'] = this.percentChange1h;
    data['percent_change_24h'] = this.percentChange24h;
    data['percent_change_7d'] = this.percentChange7d;
    data['market_cap'] = this.marketCap;
    data['last_updated'] = this.lastUpdated;
    return data;
  }
}
