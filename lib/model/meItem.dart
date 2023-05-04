class MeListItem {
  String? name;
  String? explain;
  String? icon;
  String? route;

  MeListItem({
    this.name,
    this.explain,
    this.icon,
    this.route
});

  factory MeListItem.fromJson(Map<String, dynamic> json) {
    return MeListItem(
      name: json['name'],
      explain: json['explain'],
      icon: json['icon'],
      route: json['route'],
    );
  }

  Map<String, dynamic> toJson()=>{
    'name':name,
    'explain':explain,
    'icon':icon,
    'route':route
  };
}