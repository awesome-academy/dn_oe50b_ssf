// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.


import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "bootstrap"
import I18n from "i18n-js"
import "../stylesheets/application";
require("jquery")
require("packs/reply")
require("packs/handle_request_order")
require("packs/handle_order_user")
require("packs/order")
window.I18n = I18n
Rails.start()
Turbolinks.start()
ActiveStorage.start()
