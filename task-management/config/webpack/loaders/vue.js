module.exports = {
  test: /\.vue(\.erb)?$/,
  use: [{
    loader: 'vue-loader'
  }]
}

// webpacker3以上では、extractCSSが動かない
const extractCSS = false
