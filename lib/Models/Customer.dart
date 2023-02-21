
class Customer {

  final String? id;

  late String? CName;
  late String? ContactNo;
  late String? CNIC;
  late String? VehicleNo;
  late String? RCity;
  late String? EngineNo;
  late String? ChasisNo;
  late String? Model;
  late String? Maker;
  late String? Documents;
  late String? WorkStatus;


  Customer({this.id,required this.CName ,required this.ContactNo,required this.CNIC, required this.VehicleNo,required this.RCity, required this.EngineNo,required this.ChasisNo,
  required this.Model, required this.Maker,required this.Documents,required this.WorkStatus,
  });
  //getter from table after incriment


}