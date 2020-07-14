class getTripString{

  String getWeek(String combine){
    return combine.substring(2, 5);
  }

  String getDate(String combine){
    return combine.substring(7, 9).toString();
  }

  String getMonth(String combine){
    return combine.substring(10, 13).toString();
  }

  String getYear(String combine){
    return combine.substring(14, 18).toString();
  }

  String getTime(String combine){
    return combine.substring(19, 24).toString();
  }

  String getUser(String combine){
    return combine.substring(31,42).toString();
  }

  String getTurn(String combine){
    return combine.substring(42,42+int.parse(combine[0])).toString();
  }

  String getAmount(String combine){
    return combine.substring(42+int.parse(combine[0]),42+int.parse(combine[0])+int.parse(combine[1])).toString();
  }

}