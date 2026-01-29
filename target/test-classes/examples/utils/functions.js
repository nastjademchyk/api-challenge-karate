
function utils() {

  var LocalDate = Java.type('java.time.LocalDate');
  var UUID = Java.type('java.util.UUID');

  function currentDate() {
    return LocalDate.now().toString();
  }
  
  function randomEmail() {
    var ts = java.lang.System.currentTimeMillis();
    return 'user_' + ts + '@example.com';
  }

  return {
    currentDate: currentDate,
    randomEmail: randomEmail
  };
}
