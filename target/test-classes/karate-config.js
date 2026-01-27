
function fn() {
  var env = karate.env || 'local';
  karate.log('karate.env system property was:', env);

  var config = {
    env: env,
    baseUrl: ''
  };

  if (env === 'local') {
    config.baseUrl = 'https://refactored-broccoli-g44rjw7g5ggpcw7wx-8900.app.github.dev';
  }

  if (env === 'test') {
    config.baseUrl = 'https://test.my-app.example.com';
  }

  if (env === 'acc') {
    config.baseUrl = 'https://acc.my-app.example.com';
  }

  if (env === 'prod') {
    config.baseUrl = 'https://prod.my-app.example.com';
  }

  return config;
}