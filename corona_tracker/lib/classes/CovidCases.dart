class CovidCases{
  final String totalCases;
  final String totalDeath;
  final String totalRecovered;
  final String newCases;
  final String newDeaths;
  final String seriousCases;

  CovidCases({this.totalCases, this.totalRecovered, this.totalDeath,
    this.newCases,this.newDeaths,this.seriousCases});

  factory CovidCases.fromJsonMap(Map<String, dynamic> json){
    return CovidCases(
    totalCases:json["countrydata.total_cases"],
      totalRecovered:json['total_recovered'],
      totalDeath:json['total_deaths'],
      newCases:json['total_new_cases_today'],
      newDeaths:json['total_new_deaths_today'],
      seriousCases:json['total_serious_cases'],
    );
  }

}