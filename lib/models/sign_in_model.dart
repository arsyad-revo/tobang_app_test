class SignInModel {
  String? accessToken;
  String? tokenType;
  User? user;
  Status? status;

  SignInModel({this.accessToken, this.tokenType, this.user, this.status});

  SignInModel.fromJson(Map<dynamic, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (status != null) {
      data['status'] = status!.toJson();
    }
    return data;
  }
}

class User {
  Status? status;
  Data? data;

  User({this.status, this.data});

  User.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    if (status != null) {
      data['status'] = status!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Status {
  String? kode;
  String? keterangan;

  Status({this.kode, this.keterangan});

  Status.fromJson(Map<dynamic, dynamic> json) {
    kode = json['kode'];
    keterangan = json['keterangan'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kode'] = kode;
    data['keterangan'] = keterangan;
    return data;
  }
}

class Data {
  String? email;
  String? hp;
  String? firstname;
  String? lastname;
  String? grup;
  String? role;
  String? tglLahir;
  int? jenisKelamin;
  int? id;
  Status? status;
  Status? accountStatus;
  Photo? photo;
  Toko? toko;

  Data(
      {this.email,
      this.hp,
      this.firstname,
      this.lastname,
      this.grup,
      this.role,
      this.tglLahir,
      this.jenisKelamin,
      this.id,
      this.status,
      this.accountStatus,
      this.photo,
      this.toko});

  Data.fromJson(Map<dynamic, dynamic> json) {
    email = json['email'];
    hp = json['hp'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    grup = json['grup'];
    role = json['role'];
    tglLahir = json['tgl_lahir'];
    jenisKelamin = json['jenis_kelamin'];
    id = json['id'];
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    accountStatus = json['account_status'] != null
        ? Status.fromJson(json['account_status'])
        : null;
    photo = json['photo'] != null ? Photo.fromJson(json['photo']) : null;
    toko = json['toko'] != null ? Toko.fromJson(json['toko']) : null;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['email'] = email;
    data['hp'] = hp;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['grup'] = grup;
    data['role'] = role;
    data['tgl_lahir'] = tglLahir;
    data['jenis_kelamin'] = jenisKelamin;
    data['id'] = id;
    if (status != null) {
      data['status'] = status!.toJson();
    }
    if (accountStatus != null) {
      data['account_status'] = accountStatus!.toJson();
    }
    if (photo != null) {
      data['photo'] = photo!.toJson();
    }
    if (toko != null) {
      data['toko'] = toko!.toJson();
    }
    return data;
  }
}

class Photo {
  int? id;
  String? filename;
  String? caption;
  int? width;
  int? height;
  String? contentType;
  String? uri;

  Photo(
      {this.id,
      this.filename,
      this.caption,
      this.width,
      this.height,
      this.contentType,
      this.uri});

  Photo.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    filename = json['filename'];
    caption = json['caption'];
    width = json['width'];
    height = json['height'];
    contentType = json['content_type'];
    uri = json['uri'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['id'] = id;
    data['filename'] = filename;
    data['caption'] = caption;
    data['width'] = width;
    data['height'] = height;
    data['content_type'] = contentType;
    data['uri'] = uri;
    return data;
  }
}

class Toko {
  String? nama;
  String? jalan;
  String? kelurahan;
  String? kecamatan;
  String? kota;
  String? provinsi;
  String? kodepos;
  String? detailAlamat;
  int? longitude;
  int? latitude;
  String? telp;
  String? email;
  String? slogan;
  String? deskripsi;
  String? aturanBelanja;
  String? aturanRetur;
  int? id;
  Status? status;
  List<Photo>? logo;

  Toko(
      {this.nama,
      this.jalan,
      this.kelurahan,
      this.kecamatan,
      this.kota,
      this.provinsi,
      this.kodepos,
      this.detailAlamat,
      this.longitude,
      this.latitude,
      this.telp,
      this.email,
      this.slogan,
      this.deskripsi,
      this.aturanBelanja,
      this.aturanRetur,
      this.id,
      this.status,
      this.logo});

  Toko.fromJson(Map<dynamic, dynamic> json) {
    nama = json['nama'];
    jalan = json['jalan'];
    kelurahan = json['kelurahan'];
    kecamatan = json['kecamatan'];
    kota = json['kota'];
    provinsi = json['provinsi'];
    kodepos = json['kodepos'];
    detailAlamat = json['detail_alamat'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    telp = json['telp'];
    email = json['email'];
    slogan = json['slogan'];
    deskripsi = json['deskripsi'];
    aturanBelanja = json['aturan_belanja'];
    aturanRetur = json['aturan_retur'];
    id = json['id'];
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    if (json['logo'] != null) {
      logo = <Photo>[];
      json['logo'].forEach((v) {
        logo!.add(Photo.fromJson(v));
      });
    }
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['nama'] = nama;
    data['jalan'] = jalan;
    data['kelurahan'] = kelurahan;
    data['kecamatan'] = kecamatan;
    data['kota'] = kota;
    data['provinsi'] = provinsi;
    data['kodepos'] = kodepos;
    data['detail_alamat'] = detailAlamat;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['telp'] = telp;
    data['email'] = email;
    data['slogan'] = slogan;
    data['deskripsi'] = deskripsi;
    data['aturan_belanja'] = aturanBelanja;
    data['aturan_retur'] = aturanRetur;
    data['id'] = id;
    if (status != null) {
      data['status'] = status!.toJson();
    }
    if (logo != null) {
      data['logo'] = logo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
