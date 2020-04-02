const path = require('path');
const glob = require('glob');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const TerserPlugin = require('terser-webpack-plugin');
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');

const TsconfigPathsPlugin = require('tsconfig-paths-webpack-plugin');

const entry = glob.sync('../lib/megalixir_web/**/*.page.ts').reduce((acc, curr) => {
  return Object.assign(acc, {[path.basename(curr).replace('.ts', '')]: curr})
}, {['app']: ['./ts/app.ts']});

module.exports = (env, options) => ({
  optimization: {
    minimizer: [
      new TerserPlugin({ cache: true, parallel: true, sourceMap: false }),
      new OptimizeCSSAssetsPlugin({})
    ]
  },
  entry,
  output: {
    filename: '[name].js',
    path: path.resolve(__dirname, '../priv/static/js')
  },
  module: {
    rules: [
      {
        test: /\.(j|t)s$/,
        exclude: /node_modules/,
        use: [
          {
            loader: 'babel-loader'
          },
          {
            loader: 'ts-loader',
            options: {
              configFile: 'tsconfig.json'
            }
          }
        ]
      },
      {
        test: /\.scss$/,
        use: [
          MiniCssExtractPlugin.loader,
          {
            loader: 'css-loader',
            options: {
              importLoaders: 1,
            }
          },
          {
            loader: 'sass-loader',
            options: {}
          }
        ]
      }
    ]
  },
  resolve: {
    extensions: [".ts", ",js"],
    alias: {
      Themes: path.resolve(__dirname, 'scss/themes/'),
      App: path.resolve(__dirname, '../lib/megalixir_web/')
    }
  },
  plugins: [
    new MiniCssExtractPlugin({ filename: '../css/[name].css' }),
    new CopyWebpackPlugin([{ from: 'static/', to: '../' }]),
  ]
});
