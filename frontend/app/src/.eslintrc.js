module.exports = {
    "parser": "babel-eslint",
    "extends": ["eslint:recommended", "plugin:react/recommended"],
    "ecmaFeatures": {
        "experimentalObjectRestSpread": true,
        "jsx": true
    },
    "env": {
        "browser": true,
        "es6": true
    },
    "parserOptions": {
        "sourceType": "module",
        "allowImportExportEverywhere": false,
        "codeFrame": false,
        "ecmaFeatures": {"jsx": true}
    },
    "strict": [2, "never"],
    "react/jsx-uses-react": 2,
    "react/jsx-uses-vars": 2,
    "react/react-in-jsx-scope": 2,
    "plugins": [
        "react"
    ],
    "rules": {
        "indent": [
            "error",
            2
        ],
        "linebreak-style": [
            "error",
            "unix"
        ],
        "quotes": [
            "error",
            "double"
        ]
    }
};
