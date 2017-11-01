var SsoPlugin = function () {}

SsoPlugin.prototype.isPlatformIOS = function () {
    var isPlatformIOS = device.platform == 'iPhone'
        || device.platform == 'iPad'
        || device.platform == 'iPod touch'
        || device.platform == 'iOS'
    return isPlatformIOS
}

// SsoPlugin.prototype.error_callback = function (msg) {
//     console.log('Javascript Callback Error: ' + msg)
// }

SsoPlugin.prototype.call_native = function (success,error,name, args ) {
    ret = cordova.exec(success, error, 'SsoPlugin', name, args)
    return ret
}


SsoPlugin.prototype.getSsoToken = function (success,error) {
        this.call_native(success,error,'getSsoToken')
}
SsoPlugin.prototype.logoutToken = function (success,error) {
        this.call_native(success,error,'logoutToken')
}


if (!window.plugins) {
    window.plugins = {}
}

if (!window.plugins.iSsoPlugin) {
    window.plugins.iSsoPlugin = new SsoPlugin()
}

module.exports = new SsoPlugin()
