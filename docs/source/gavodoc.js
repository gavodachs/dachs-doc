// Misc Javascript hacks for GAVO's documentation suite

// display sphinx-like destinations for divs with an id


function _addAnchor(ev) {
	var anchor = $("<a class='linkAnchor'>¶</a>");
	anchor[0].setAttribute("href", "#"+this.parentNode.id);
	this.appendChild(anchor[0]);
}


function _removeAnchor(ev) {
	$(this).find(".linkAnchor").remove();
}


function _addAnchorShower(index, el) {
	if (el.getAttribute("id")) {
		var dest = el.firstChild.nextSibling;
		$(dest).bind("mouseenter", _addAnchor);
		$(dest).bind("mouseleave", _removeAnchor);
	}
}


$(document).ready(function () {
	$("div").map(_addAnchorShower);
});

