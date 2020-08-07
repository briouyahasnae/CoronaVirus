class IP_info{
  final String IP;
  final String city;
  final String ZIP;
  final String st_code;
  final String state_name;
  final String country_code;
  final String country;
  final double x;
  final double y;


  IP_info({this.IP, this.city, this.st_code,this.ZIP,
    this.state_name,this.country_code,this.country,this.x,this.y});

  factory IP_info.fromJson(Map<String, dynamic> json){
    return IP_info(
      IP:json['query'],
      ZIP:json['zip'],
      city:json['city'],
      country_code:json['countryCode'],
      st_code:json['region'],
      country:json['country'],
      state_name:json['regionName'],
      x:json['lat'],
      y:json['lon']

    );
  }

}
