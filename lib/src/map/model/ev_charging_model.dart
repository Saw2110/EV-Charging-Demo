class EvChargingModel {
  EvChargingModel({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.entity,
    required this.entityType,
    required this.email,
    required this.kahaId,
    required this.contact,
    required this.tag,
    required this.locatedInTag,
    required this.parentTag,
    required this.landline,
    required this.address,
    required this.location,
    required this.distance,
    required this.panIsVat,
    required this.tagLine,
    required this.website,
    required this.description,
    required this.workingDaysAndHours,
    required this.pickup,
    required this.delivery,
    required this.available,
    required this.isOfficial,
    required this.avatar,
    required this.coverImageUrl,
    required this.buildingImageUrl,
    required this.gallery,
    required this.buildingInformation,
    required this.floorNo,
    required this.homeId,
    required this.view360Url,
    required this.additionalInfo,
    required this.rejectionReason,
    required this.status,
    required this.category,
    required this.mapAddress,
    required this.openingHours,
    required this.closingHours,
    required this.longitude,
    required this.latitude,
    required this.isFavourited,
  });

  final int id;
  final DateTime? createdAt;
  final String name;
  final String entity;
  final List<String> entityType;
  final String email;
  final String kahaId;
  final dynamic contact;
  final String tag;
  final dynamic locatedInTag;
  final dynamic parentTag;
  final dynamic landline;
  final String address;
  final Location? location;
  final int distance;
  final bool panIsVat;
  final dynamic tagLine;
  final String website;
  final String description;
  final WorkingDaysAndHours? workingDaysAndHours;
  final bool pickup;
  final bool delivery;
  final bool available;
  final bool isOfficial;
  final dynamic avatar;
  final dynamic coverImageUrl;
  final dynamic buildingImageUrl;
  final List<dynamic> gallery;
  final dynamic buildingInformation;
  final dynamic floorNo;
  final dynamic homeId;
  final dynamic view360Url;
  final dynamic additionalInfo;
  final dynamic rejectionReason;
  final Status? status;
  final Category? category;
  final MapAddress? mapAddress;
  final String openingHours;
  final String closingHours;
  final double longitude;
  final double latitude;
  final dynamic isFavourited;

  factory EvChargingModel.fromJson(Map<String, dynamic> json) {
    return EvChargingModel(
      id: json["id"] ?? 0,
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      name: json["name"] ?? "",
      entity: json["entity"] ?? "",
      entityType: json["entityType"] == null
          ? []
          : List<String>.from(json["entityType"]!.map((x) => x)),
      email: json["email"] ?? "",
      kahaId: json["kahaId"] ?? "",
      contact: json["contact"],
      tag: json["tag"] ?? "",
      locatedInTag: json["locatedInTag"],
      parentTag: json["parentTag"],
      landline: json["landline"],
      address: json["address"] ?? "",
      location:
          json["location"] == null ? null : Location.fromJson(json["location"]),
      distance: json["distance"] ?? 0,
      panIsVat: json["panIsVat"] ?? false,
      tagLine: json["tagLine"],
      website: json["website"] ?? "",
      description: json["description"] ?? "",
      workingDaysAndHours: json["workingDaysAndHours"] == null
          ? null
          : WorkingDaysAndHours.fromJson(json["workingDaysAndHours"]),
      pickup: json["pickup"] ?? false,
      delivery: json["delivery"] ?? false,
      available: json["available"] ?? false,
      isOfficial: json["isOfficial"] ?? false,
      avatar: json["avatar"],
      coverImageUrl: json["coverImageUrl"],
      buildingImageUrl: json["buildingImageUrl"],
      gallery: json["gallery"] == null
          ? []
          : List<dynamic>.from(json["gallery"]!.map((x) => x)),
      buildingInformation: json["buildingInformation"],
      floorNo: json["floorNo"],
      homeId: json["homeId"],
      view360Url: json["view360Url"],
      additionalInfo: json["additionalInfo"],
      rejectionReason: json["rejectionReason"],
      status: json["status"] == null ? null : Status.fromJson(json["status"]),
      category:
          json["category"] == null ? null : Category.fromJson(json["category"]),
      mapAddress: json["mapAddress"] == null
          ? null
          : MapAddress.fromJson(json["mapAddress"]),
      openingHours: json["openingHours"] ?? "",
      closingHours: json["closingHours"] ?? "",
      longitude: json["longitude"] ?? 0.0,
      latitude: json["latitude"] ?? 0.0,
      isFavourited: json["isFavourited"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "name": name,
        "entity": entity,
        "entityType": entityType.map((x) => x).toList(),
        "email": email,
        "kahaId": kahaId,
        "contact": contact,
        "tag": tag,
        "locatedInTag": locatedInTag,
        "parentTag": parentTag,
        "landline": landline,
        "address": address,
        "location": location?.toJson(),
        "distance": distance,
        "panIsVat": panIsVat,
        "tagLine": tagLine,
        "website": website,
        "description": description,
        "workingDaysAndHours": workingDaysAndHours?.toJson(),
        "pickup": pickup,
        "delivery": delivery,
        "available": available,
        "isOfficial": isOfficial,
        "avatar": avatar,
        "coverImageUrl": coverImageUrl,
        "buildingImageUrl": buildingImageUrl,
        "gallery": gallery.map((x) => x).toList(),
        "buildingInformation": buildingInformation,
        "floorNo": floorNo,
        "homeId": homeId,
        "view360Url": view360Url,
        "additionalInfo": additionalInfo,
        "rejectionReason": rejectionReason,
        "status": status?.toJson(),
        "category": category?.toJson(),
        "mapAddress": mapAddress?.toJson(),
        "openingHours": openingHours,
        "closingHours": closingHours,
        "longitude": longitude,
        "latitude": latitude,
        "isFavourited": isFavourited,
      };
}

class Category {
  Category({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.iconUrl,
    required this.markerUrl,
    required this.priority,
    required this.isVisible,
    required this.parent,
  });

  final int id;
  final DateTime? createdAt;
  final String name;
  final String iconUrl;
  final String markerUrl;
  final int priority;
  final bool isVisible;
  final Category? parent;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["id"] ?? 0,
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      name: json["name"] ?? "",
      iconUrl: json["iconUrl"] ?? "",
      markerUrl: json["markerUrl"] ?? "",
      priority: json["priority"] ?? 0,
      isVisible: json["isVisible"] ?? false,
      parent: json["parent"] == null ? null : Category.fromJson(json["parent"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "name": name,
        "iconUrl": iconUrl,
        "markerUrl": markerUrl,
        "priority": priority,
        "isVisible": isVisible,
        "parent": parent?.toJson(),
      };
}

class Location {
  Location({
    required this.type,
    required this.coordinates,
  });

  final String type;
  final List<double> coordinates;

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json["type"] ?? "",
      coordinates: json["coordinates"] == null
          ? []
          : List<double>.from(json["coordinates"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates.map((x) => x).toList(),
      };
}

class MapAddress {
  MapAddress({
    required this.id,
    required this.createdAt,
    required this.street,
    required this.province,
    required this.district,
    required this.municipality,
    required this.wardNo,
    required this.generalAddress,
    required this.latitude,
    required this.longitude,
    required this.country,
    required this.additionalInfo,
    required this.location,
    required this.googlePlacesData,
  });

  final int id;
  final DateTime? createdAt;
  final String street;
  final dynamic province;
  final dynamic district;
  final String municipality;
  final dynamic wardNo;
  final String generalAddress;
  final String latitude;
  final String longitude;
  final String country;
  final dynamic additionalInfo;
  final Location? location;
  final dynamic googlePlacesData;

  factory MapAddress.fromJson(Map<String, dynamic> json) {
    return MapAddress(
      id: json["id"] ?? 0,
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      street: json["street"] ?? "",
      province: json["province"],
      district: json["district"],
      municipality: json["municipality"] ?? "",
      wardNo: json["wardNo"],
      generalAddress: json["generalAddress"] ?? "",
      latitude: json["latitude"] ?? "",
      longitude: json["longitude"] ?? "",
      country: json["country"] ?? "",
      additionalInfo: json["additionalInfo"],
      location:
          json["location"] == null ? null : Location.fromJson(json["location"]),
      googlePlacesData: json["googlePlacesData"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "street": street,
        "province": province,
        "district": district,
        "municipality": municipality,
        "wardNo": wardNo,
        "generalAddress": generalAddress,
        "latitude": latitude,
        "longitude": longitude,
        "country": country,
        "additionalInfo": additionalInfo,
        "location": location?.toJson(),
        "googlePlacesData": googlePlacesData,
      };
}

class Status {
  Status({
    required this.id,
    required this.createdAt,
    required this.type,
    required this.value,
  });

  final int id;
  final DateTime? createdAt;
  final String type;
  final String value;

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      id: json["id"] ?? 0,
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      type: json["type"] ?? "",
      value: json["value"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "type": type,
        "value": value,
      };
}

class WorkingDaysAndHours {
  WorkingDaysAndHours({
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
  });

  final String monday;
  final String tuesday;
  final String wednesday;
  final String thursday;
  final String friday;
  final String saturday;
  final String sunday;

  factory WorkingDaysAndHours.fromJson(Map<String, dynamic> json) {
    return WorkingDaysAndHours(
      monday: json["monday"] ?? "",
      tuesday: json["tuesday"] ?? "",
      wednesday: json["wednesday"] ?? "",
      thursday: json["thursday"] ?? "",
      friday: json["friday"] ?? "",
      saturday: json["saturday"] ?? "",
      sunday: json["sunday"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "monday": monday,
        "tuesday": tuesday,
        "wednesday": wednesday,
        "thursday": thursday,
        "friday": friday,
        "saturday": saturday,
        "sunday": sunday,
      };
}
