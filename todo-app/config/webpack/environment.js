const { environment } = require('@rails/webpacker')

// TODO
// jQueryとBootstapのJSを使えるように
const webpack = require('webpack')
environment.plugins.prepend(
    'Provide',
    new webpack.ProvidePlugin({
        $: 'jquery',
        jQuery: 'jquery',
        Popper: ['popper.js', 'default']
    })
)

module.exports = environment
