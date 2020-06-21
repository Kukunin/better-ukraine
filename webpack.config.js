const webpack = require('webpack');
const path = require('path');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');

module.exports = {
  entry: {
    site: ['./assets/javascripts/index.js', './assets/stylesheets/index.scss']
  },
  output: {
    filename: 'assets/javascripts/[name].js',
    path: path.resolve(__dirname, '.tmp/dist')
  },
  module: {
    rules: [
      {
        test: /\.(sa|sc|c)ss$/,

        use: [
          MiniCssExtractPlugin.loader,
          { loader: "css-loader" },
          {
            loader: "postcss-loader",
            options: {
              plugins: () => ([
                require('autoprefixer'),
              ])
            }
          },
          { loader: "sass-loader" },
        ]
      },
      {
        test: /\.woff2?$|\.ttf$|\.eot$|\.svg$/,
        loader: 'file-loader',
        options: {
          publicPath: '../..',
        },
      },
    ],
  },
  plugins: [
    new MiniCssExtractPlugin({
      filename: 'assets/stylesheets/[name].css',
      path: path.resolve(__dirname, '.tmp/dist')
    }),
    new webpack.ProvidePlugin({
      jQuery: 'jquery-slim',
      $: 'jquery-slim'
    }),
  ],

  mode: 'development'
};
