var path = require("path");
var merge = require("webpack-merge");
var ExtractTextPlugin = require("extract-text-webpack-plugin");
var HtmlWebpackPlugin = require("html-webpack-plugin");


var common = {
  module: {
    rules: [
      {
        test: [/\.js$/],
        exclude: [/node_modules/],
        use: "babel-loader",
      },
      {
        test: [/\.scss$/, /\.css$/],
        loader: ExtractTextPlugin.extract({
          fallback: "style-loader",
          use: "css-loader!sass-loader"
        })
      },
      {
        test: /\.(png|jpg|gif|svg)$/,
        use: "file-loader?name=images/[name].[ext]"
      },
      {
        test: /\.(ttf|eot|svg|woff2?)$/,
        use: "file-loader?name=fonts/[name].[ext]",
      },
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        use: [
          {
            loader: "elm-webpack-loader",
            options: {
              cwd: path.resolve(__dirname)
            }
          }
        ]
      },
    ],
    noParse: [/\.elm$/]
  }
};

module.exports = [
  merge(common, {
    entry: [
      "font-awesome-loader",
      "./public/pic_100x100.jpg",
      "./app/app.scss",
      "./app/app.js"
    ],
    output: {
      path: path.resolve(__dirname, "build"),
      filename: "app.js"
    },
    resolve: {
      modules: [
        "node_modules",
        path.resolve(__dirname, "app")
      ]
    },
    plugins: [
      new ExtractTextPlugin("app.css"),
      new HtmlWebpackPlugin({
        filename: "index.html",
        template: path.resolve(__dirname, "app", "index.html"),
        inject:   "body"
      }),
    ]
  })
];
