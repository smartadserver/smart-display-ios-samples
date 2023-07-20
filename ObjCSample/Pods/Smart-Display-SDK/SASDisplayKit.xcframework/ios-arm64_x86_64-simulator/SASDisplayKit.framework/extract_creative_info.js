/**
 Extract various size information from the ad webview for logging purposes.
 */

var largestChildrenWidth = Array.from(document.body.children).reduce((accumulator, currentValue) => accumulator < currentValue.clientWidth ? currentValue.clientWidth : accumulator, 0);
var largestChildrenHeight = Array.from(document.body.children).reduce((accumulator, currentValue) => accumulator < currentValue.clientHeight ? currentValue.clientHeight : accumulator, 0);

var result = {
    "largestChildren": {
        "width": largestChildrenWidth,
        "height": largestChildrenHeight
    },
    "bodySize": {
        "width": document.body.clientWidth,
        "height": document.body.clientHeight
    },
    "bodyScrollSize": {
        "width": document.body.scrollWidth,
        "height": document.body.scrollHeight
    },
    "bodyComputedStyleSize": {
        "width": window.getComputedStyle(document.body, null).width,
        "height": window.getComputedStyle(document.body, null).height
    },
    "documentScrollSize": {
        "width": document.documentElement.scrollWidth,
        "height": document.documentElement.scrollHeight
    },
    "windowSize": {
        "width": window.innerWidth,
        "height": window.innerHeight
    },
    "hasVideo": document.querySelector('video') != null
};

result
