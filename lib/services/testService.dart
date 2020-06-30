

class TestService{
    String testData  = "gg";
    
  
   setDataValue(String value){
    this.setDataValue(value);
  }
  static void  setData(String value){
    TestService t1 = TestService();
    t1.setDataValue(value);
  }
   String getData(){
    return this.testData;
  }
}


class test1{
 final var11  =  TestService.setData("value");
}