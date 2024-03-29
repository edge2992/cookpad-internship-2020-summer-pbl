window.LineIt = window.LineIt || {},
    function () {
        function t() {}

        function e(t, e) {
            this.entry = t, this.buttonType = e, this.elIframe = document.createElement("iframe"), this.params = [], this.lang = "en", this.env = "REAL", this.ver = "1"
        }

        function i(t) {
            e.call(this, t, s.BUTTON_TYPES.SHARE), this.init()
        }

        function a(t) {
            e.call(this, t, s.BUTTON_TYPES.FRIEND), this.init()
        }

        function n(t) {
            e.call(this, t, s.BUTTON_TYPES.LIKE), this.init()
        }

        function r(t, e, i) {
            t && (i && (t = t.toLowerCase()), this.params.push(e + "=" + encodeURIComponent(t)))
        }
        var s = {
            BUTTON_TYPES: {
                SHARE: "SHARE",
                FRIEND: "FRIEND",
                LIKE: "LIKE"
            },
            IMG_SIZE: {},
            BUTTON_URL: {
                HOST: {
                    REAL: "https://social-plugins.line.me"
                }
            }
        };
        s.BUTTON_URL[s.BUTTON_TYPES.SHARE] = "/widget/share?", s.BUTTON_URL[s.BUTTON_TYPES.FRIEND] = "/widget/friend?", s.BUTTON_URL[s.BUTTON_TYPES.LIKE] = "/widget/like?";
        var o = [],
            l = function () {
                var e = document.querySelectorAll(".line-it-button"),
                    i = new t;
                Array.prototype.forEach.call(e, function (t) {
                    if ("div" === t.tagName.toLowerCase()) {
                        var e = i.makeButton(t);
                        o.push(e)
                    }
                })
            },
            h = document.readyState;
        "interactive" === h || "complete" === h ? window.addEventListener("load", l, !1) : document.addEventListener("DOMContentLoaded", l, !1), t.prototype.makeButton = function (t) {
            var e = t.getAttribute("data-type");
            if (e) {
                switch (e.split("-")[0].toUpperCase()) {
                    case s.BUTTON_TYPES.SHARE:
                        return new i(t);
                    case s.BUTTON_TYPES.FRIEND:
                        return new a(t);
                    case s.BUTTON_TYPES.LIKE:
                        return new n(t)
                }
            }
        }, e.prototype.initDefaultAttributes = function () {
            Array.prototype.forEach.call(this.entry.attributes, function (t) {
                var e = t.name.match(/^data\-(.+)$/);
                if (null != e) {
                    switch (e[1]) {
                        case "lang":
                            this.lang = t.value, this.params.push(e[1] + "=" + encodeURIComponent(t.value));
                            break;
                        case "type":
                            var i = t.value.split("-");
                            this.params.push(e[1] + "=" + encodeURIComponent(i[0]));
                            break;
                        case "env":
                            "BETA" !== t.value && "RC" !== t.value && "LOCAL" !== t.value || (this.env = t.value), this.params.push(e[1] + "=" + encodeURIComponent(this.env));
                            break;
                        case "ver":
                            this.ver = t.value, this.params.push(e[1] + "=" + encodeURIComponent(this.ver))
                    }
                    this.elIframe.setAttribute(t.name, t.value)
                }
            }.bind(this)), this.elIframe.setAttribute("data-line-it-id", o.length), this.elIframe.setAttribute("scrolling", "no"), this.elIframe.setAttribute("frameborder", "0"), this.elIframe.setAttribute("allowtransparency", "true"), this.params.push("id=" + o.length), this.params.push("origin=" + encodeURIComponent(location.href)), this.params.push("title=" + encodeURIComponent(document.title))
        }, e.prototype.setIframeStyle = function () {
            this.elIframe.setAttribute("style", "width: 0px; height: 0px; visibility: visible; position:static !important; opacity:1 !important"), this.elIframe.className = "line-it-button"
        }, e.prototype.setIframeSrc = function () {
            this.elIframe.src = s.BUTTON_URL.HOST[this.env] + s.BUTTON_URL[this.buttonType] + this.params.join("&")
        }, e.prototype.validateParam = function (t) {
            for (var e = 0; e < this.params.length; e++) {
                if (this.params[e].split("=")[0] == t) return !0
            }
            return !1
        }, e.prototype.attach = function () {
            this.initDefaultAttributes(), this.setIframeStyle(), this.setIframeSrc(), this.entry.parentNode.replaceChild(this.elIframe, this.entry)
        }, i.prototype = new e, i.prototype.constructor = i, i.prototype.setAdditionalParams = function () {
            r.call(this, this.entry.getAttribute("data-url"), "url"), r.call(this, this.entry.getAttribute("data-type"), "buttonType", !0), r.call(this, this.entry.getAttribute("data-size"), "size", !0), r.call(this, this.entry.getAttribute("data-count"), "count"), r.call(this, this.entry.getAttribute("data-color"), "color", !0), r.call(this, this.entry.getAttribute("data-dummyCount"), "dummyCount")
        }, i.prototype.init = function () {
            this.setAdditionalParams(), this.attach()
        }, a.prototype = new e, a.prototype.constructor = a, a.prototype.setAdditionalParams = function () {
            r.call(this, this.entry.getAttribute("data-lineId"), "lineId"), r.call(this, this.entry.getAttribute("data-count"), "count"), r.call(this, this.entry.getAttribute("data-home"), "home")
        }, a.prototype.init = function () {
            this.setAdditionalParams(), this.validateParam("lineId") && this.attach()
        }, n.prototype = new e, n.prototype.constructor = n, n.prototype.setAdditionalParams = function () {
            r.call(this, this.entry.getAttribute("data-url"), "url"), r.call(this, this.entry.getAttribute("data-share"), "includeShare"), r.call(this, this.entry.getAttribute("data-lineId"), "lineId")
        }, n.prototype.init = function () {
            this.setAdditionalParams(), this.validateParam("url") && this.attach()
        }, null == window.LineIt.loadButton && (window.LineIt.loadButton = l, window.addEventListener("message", function (t) {
            var e = t.data,
                i = !1;
            for (var a in s.BUTTON_URL.HOST) t.origin === s.BUTTON_URL.HOST[a] && (i = !0);
            if ("https://timeline.line.me" === t.origin && (i = !0), i && /^\{.+\}$/.test(e)) {
                var n = JSON.parse(e),
                    r = o[n.buttonId];
                if ("setTitle" == n.type && (r.elIframe.title = n.title), "resize" === n.type && (r.elIframe.style.width = n.width + "px", r.elIframe.style.height = n.height + "px", r = null), "refresh" === n.type)
                    for (var l = 0; l < o.length; l++) {
                        var h = o[l].elIframe;
                        h && l != n.buttonId && (h.src = h.src)
                    }
            }
        }))
    }();