class WikiQueryModel {
  bool? batchcomplete;
  Continue? continu;
  Query? query;

  WikiQueryModel({this.batchcomplete, this.continu, this.query});

  WikiQueryModel.fromJson(Map<String, dynamic> json) {
    batchcomplete = json['batchcomplete'];
    continu = json['continue'] != null
        ? new Continue.fromJson(json['continue'])
        : null;
    query = json['query'] != null ? new Query.fromJson(json['query']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['batchcomplete'] = this.batchcomplete;
    if (this.continu != null) {
      data['continue'] = this.continu?.toJson();
    }
    if (this.query != null) {
      data['query'] = this.query?.toJson();
    }
    return data;
  }
}

class Continue {
  int? gpsoffset;
  String? continu;

  Continue({this.gpsoffset, this.continu});

  Continue.fromJson(Map<String, dynamic> json) {
    gpsoffset = json['gpsoffset'];
    continu = json['continue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gpsoffset'] = this.gpsoffset;
    data['continue'] = this.continu;
    return data;
  }
}

class Query {
  List<Redirects>? redirects;
  List<Pages>? pages;

  Query({this.redirects, this.pages});

  Query.fromJson(Map<String, dynamic> json) {
    if (json['redirects'] != null) {
      redirects = <Redirects>[];
      json['redirects'].forEach((v) {
        redirects?.add(new Redirects.fromJson(v));
      });
    }
    if (json['pages'] != null) {
      pages = <Pages>[];
      json['pages'].forEach((v) {
        pages?.add(new Pages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.redirects != null) {
      data['redirects'] = this.redirects?.map((v) => v.toJson()).toList();
    }
    if (this.pages != null) {
      data['pages'] = this.pages?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Redirects {
  int? index;
  String? from;
  String? to;

  Redirects({this.index, this.from, this.to});

  Redirects.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['index'] = this.index;
    data['from'] = this.from;
    data['to'] = this.to;
    return data;
  }
}

class Pages {
  int? pageid;
  int? ns;
  String? title;
  int? index;
  Thumbnail? thumbnail;
  Terms? terms;

  Pages(
      {this.pageid,
      this.ns,
      this.title,
      this.index,
      this.thumbnail,
      this.terms});

  Pages.fromJson(Map<String, dynamic> json) {
    pageid = json['pageid'];
    ns = json['ns'];
    title = json['title'];
    index = json['index'];
    thumbnail = json['thumbnail'] != null
        ? new Thumbnail.fromJson(json['thumbnail'])
        : null;
    terms = json['terms'] != null ? new Terms.fromJson(json['terms']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageid'] = this.pageid;
    data['ns'] = this.ns;
    data['title'] = this.title;
    data['index'] = this.index;
    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail?.toJson();
    }
    if (this.terms != null) {
      data['terms'] = this.terms?.toJson();
    }
    return data;
  }
}

class Thumbnail {
  String? source;
  int? width;
  int? height;

  Thumbnail({this.source, this.width, this.height});

  Thumbnail.fromJson(Map<String, dynamic> json) {
    source = json['source'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['source'] = this.source;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}

class Terms {
  List<String>? description;

  Terms({this.description});

  Terms.fromJson(Map<String, dynamic> json) {
    description = json['description'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    return data;
  }
}
