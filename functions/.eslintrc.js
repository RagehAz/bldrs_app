
module.exports = {
  root: true,
  env: {
    es6: true,
    node: true,
  },
  extends: [
    'eslint:recommended',
    'google',
  ],
  rules: {
    'linebreak-style': 0,
    'quotes': [2, 'single', {'avoidEscape': true}],
    'max-len': ['error', {'code': 120}],
    // quotes: ["error", "double"],
  },
  parserOptions: {
    // Required for certain syntax usages
    'ecmaVersion': 2017,
  },
};
