<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">

.sc_group {
    margin-left: 5px;
    margin-top: 5px;
}

.sc_group_label {
    font-weight: bold;
}

.sc_group_b {
    padding-top:10px;
    padding-left:5px;
}

.sc_info { 
    font-weight: normal;
}

.sc_success {
    color: green;
    font-weight: normal;
}

.sc_success_em {
    color: green;
    font-weight: bold;
}

.sc_success_detail {
    color: black;
    font-size: 12px;
    background-color: gainsboro;
    font-style: italic;
    font-family: Candara, Tahoma, Arial, sans-serif;
}

.sc_error {
    color: red;
    font-weight: normal;
}

.sc_error_em {
    color: red;
    font-weight: bold;
}

.sc_warn {
    color: orange;
    font-weight: normal;
}

.sc_warn_em {
    color: orange;
    font-weight: bold;
}

.sc_exception {
    color: black;
    font-family: monospace;
    font-size: 12px;
    background-color: gainsboro;
}

.sc_info_detail {
    color: black;
    font-size: 80%;
    background-color: gainsboro;
}

.sc_advice_em {
    color: darkcyan;
    font-weight: bold;
}

.sc_advice {
    color: darkcyan;
    font-size: 12px;
    font-weight: normal;
    font-style: italic;
}

.sc_advice_detail {
    color: black;
    font-size: 12px;
    font-style: italic;
    background-color: gainsboro;
    font-family: Candara, Tahoma, Arial, sans-serif;
}

.SHeader {
	font-weight: bold;
}

</style>

<script type="text/javascript">
//<![CDATA[

    function toggleDisplay(ElementId) {
        var elm = document.getElementById(ElementId);
        if (elm) {
            (elm.style.display == 'none') ? elm.style.display = 'block' : elm.style.display = 'none';
        }
        return false;
    }

    function addTOCItem(tocItemId, tocItemLabel, tocItemHref) {
        var nItem = document.createElement("li");
        var nItemLink = document.createElement("a");
        nItemLink.setAttribute("href", tocItemHref);
        nItemLink.setAttribute("id", tocItemId);
        if (tocLevel == 2) {
            nItem.setAttribute("class", "SHeader");
        }
            
        nItemLink.appendChild(document.createTextNode(tocItemLabel));
        nItem.appendChild(nItemLink);
        lastTocElement.appendChild(nItem);
    }

    function tocLevelDown() {
        if (tocLevel > 1) {
            var elUl = document.createElement("ul");
            var elLi = document.createElement("li");
            elUl.setAttribute("class", "UI Bullets");
            elLi.appendChild(elUl);
            lastTocElement.appendChild(elLi);
            lastTocElement = elUl;
        }
        tocLevel++;
    }

    function tocLevelUp() {
        if (tocLevel > 1) {
            lastTocElement = lastTocElement.parentNode.parentNode;
        }
        tocLevel--;
    }
    function cleanToc(rootEl) {
        while (rootEl.firstChild) {
            rootEl.removeChild(rootEl.firstChild);
        }
    }

    function modifyTocItem(itemId, toLabelAppend, toLabelAppendClass) {
        var item = document.getElementById(itemId);
        if (item != null) {
            var text = item.parentNode.innerHTML
            item.parentNode.innerHTML = text + "<span class=\"" + toLabelAppendClass + "\"> " + toLabelAppend + "<\/span>";
        }
    }

//]]>
</script>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.config.selftest.SelfTestMessages"
	var="selfTest_Messages" />
	
<syswf:block className="UI Block Green">
	<div class="Content">
		<div class="Offset">
			<noscript><c:out value="${selfTestReport}"/></noscript>
			<ul id="TOCroot"><li>&nbsp;</li></ul>
			<script type="text/javascript">
//<![CDATA[

			    var lastTocElement = document.getElementById("TOCroot");
			    var tocLevel = 1;
			    cleanToc(lastTocElement);
			
//]]>
</script>			
		</div>
	</div>
</syswf:block>

<div class="UI Block Common">
	<div class="UI Edge">
		<div class="UI Edge">
			<div class="UI Edge">
				<div class="UI Edge">
					<div class="UI Canvas">
						<div class="Content">
							<div class="Offset">
							   <c:out value="${selfTestReport}" escapeXml="false"/>								
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>