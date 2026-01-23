
function utils() {

  var LocalDate = Java.type('java.time.LocalDate');
  var UUID = Java.type('java.util.UUID');

  function currentDate() {
    return LocalDate.now().toString();
  }

  function datePlus(days) {
    return LocalDate.now().plusDays(days).toString();
  }

  function dateMinus(days) {
    return LocalDate.now().minusDays(days).toString();
  }

  function randomString() {
    return UUID.randomUUID().toString().replace('-', '').substring(0, 8);
  }

  function randomEmail() {
    var ts = java.lang.System.currentTimeMillis();
    return 'user_' + ts + '@example.com';
  }

  return {
    currentDate: currentDate,
    datePlus: datePlus,
    dateMinus: dateMinus,
    randomString: randomString,
    randomEmail: randomEmail
  };
}
