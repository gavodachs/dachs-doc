// Misc Javascript hacks for GAVO's documentation suite
// display sphinx-like destinations for divs with an id

"use strict"

function _addAnchor(ev) {
	// ev has fired on the headline; make a link to the parent div.
	let anchor = document.createElement('a');
	anchor.className = "linkAnchor";
	anchor.innerHTML = "¶";
	anchor.href = "#"+ev.currentTarget.parentNode.id;
	ev.currentTarget.append(anchor);
}


function _removeAnchor(ev) {
	for (let el of ev.currentTarget.querySelectorAll(".linkAnchor")) {
		el.remove();
	}
}


function _addAnchorShower(el) {
	if (el.id) {
		// this is a div; we'd like to operate on the headline, which is
		// the second child (the first is a text node).
		let dest = el.childNodes[1];
		dest.addEventListener("mouseenter", _addAnchor);
		dest.addEventListener("mouseleave", _removeAnchor);
	}
}


document.addEventListener('DOMContentLoaded',
	function () {
		for (let el of document.querySelectorAll("div")) {
			_addAnchorShower(el);
	}
});
