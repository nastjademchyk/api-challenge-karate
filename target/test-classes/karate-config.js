//function fn() {
//  var env = karate.env; // get system property 'karate.env'
//  karate.log('karate.env system property was:', env);
//  if (!env) {
//    env = 'dev';
//  }
//  var config = {
//    env: env,
//    myVarName: 'someValue'
//  }
//  if (env == 'dev') {
//    // customize
//    // e.g. config.foo = 'bar';
//  } else if (env == 'e2e') {
//    // customize
//  }
//  return config;
//}
//

function fn() {
  var env = karate.env || 'local';
  karate.log('karate.env system property was:', env);

  var config = {
    env: env,
    baseUrl: 'https://refactored-broccoli-g44rjw7g5ggpcw7wx-8900.app.github.dev'
  };

  if (env === 'local') {
    config.baseUrl = 'https://refactored-broccoli-g44rjw7g5ggpcw7wx-8900.app.github.dev';
  }

  return config;
}
