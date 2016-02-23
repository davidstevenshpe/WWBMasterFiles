<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:if test="${not empty template}">
<div class="panel media pad-all bg-trans" id="${prefix}-gradient" ng-controller="emCommonController">
	<custom-template-${templateIndex} data="data${templateIndex}"></custom-template-${templateIndex}>
</div>


<style>
    .flippingPanel {
        height: 200px;
        width:280px;
        display: block;margin-left: auto;margin-right: auto;
        -webkit-perspective: 600px;
        -moz-perspective: 600px;
	perspective: 600px;
    }

    img.flipTile {
        border:2px;
        border-style:solid;
        border-color:white;
        height: 200px;
        opacity: 1;
        display: block;
        margin-left: auto;
        margin-right: auto;
    }

    .flippingPanel .front,
    .flippingPanel .back {
        text-align: center;
    }

    .box2 {
        height: 200px;
        width: 280px;
    }

    ol.panelEnumList {
        margin-left: auto;
        margin-right: auto;
        list-style-type:decimal;
        text-align: left;
    }

    ol.panelEnumList li {
        list-style-type:decimal;
    }

    .flippingPanel .front {
        height: inherit;
        position: absolute;
        top: 0;
        text-align: center;
        -webkit-backface-visibility: hidden;
        -moz-backface-visibility: hidden;
        -webkit-transition: all .4s ease-in-out;
        -moz-transition: all .4s ease-in-out;
        -ms-transition: all .4s ease-in-out;
        -o-transition: all .4s ease-in-out;
        transition: all .4s ease-in-out;
    }

    .flippingPanel .back {
        height: inherit;
        position: absolute;
        top: 0;
	opacity: 0;
        -webkit-backface-visibility: hidden;
        -moz-backface-visibility: hidden;
        -webkit-transition: all .4s ease-in-out;
        -moz-transition: all .4s ease-in-out;
        -ms-transition: all .4s ease-in-out;
        -o-transition: all .4s ease-in-out;
        transition: all .4s ease-in-out;
    }
    .flippingPanel.flip .front {
	opacity: 0;
    }
    .flippingPanel.flip .back {
	opacity: 1;
    }
</style>

<script type="text/javascript">//<![CDATA[

// flipbox support
$(document).ready(function(){
    // set up hover panels
    // although this can be done without JavaScript, we've attached these events
    // because it causes the hover to be triggered when the element is tapped on a touch device
    $('.hover').hover(function(){
        $(this).addClass('flip');
    },function(){
        $(this).removeClass('flip');
    });
});

var script = document.createElement('script');
script.setAttribute('type', 'text/javascript');
script.textContent = 'emCommonApp.directive("customTemplate${templateIndex}", function() { return { restrict: \'E\', scope: {data:\'=\'}, template: \'<c:out value="${template}" escapeXml="false"/>\'}});';
emCommon.dataScope['data${templateIndex}'] = {};
document.body.appendChild(script);
Ext4.onReady(function() {
	<c:if test="${(not empty template) and (not empty dql)}">
	var dqlStore=Ext4.create('EA.model.tools.DQLStore', { query: "<query>${dql}</query>", fields: []});
	dqlStore.on('load', function(res) {
		var raws = [];
		for(var i = 0; i < res.data.items.length; i++) {
			raws[i] = res.data.items[i].raw;
		}
		emCommon.scope.$apply(function() {
			emCommon.applyDataScope('data${templateIndex}', {records: raws });
		});
	});
	dqlStore.load();
	</c:if>
	<c:choose>
	<c:when test="${not empty backgroundColor}">
		var column = $('#${prefix}-gradient').parent().parent();
		column.css('background-color', '${backgroundColor}');
	</c:when>
	<c:when test="${not empty gradientor}">
	emCommon['${prefix}_renderer'] = function() {
		var column = $('#${prefix}-gradient').parent().parent();
		var colStyle = column.attr('style');
		var gradientor = emCommon['${gradientor}'];
		var self = $('#${prefix}-gradient');
		var index = self.parent().parent().attr('col-index');
		index = parseInt(index);
		var start = gradientor.generateGradientColor({
			minValue:0,
			maxValue:4,
			value: index - 1
		});
		var end = gradientor.generateGradientColor({
				minValue:0,
				maxValue:4,
				value:index
		});
		var ie = 'background:-ms-linear-gradient(top,' + start.color + ' 0%,' + end.color + ' 100%);';
		var cf = 'background:linear-gradient(to bottom right,' + start.color + ',' + end.color + ');';
		column.attr('style', colStyle + ie + cf);
	}
	if(emCommon['${gradientor}'] != null) {
		emCommon['${prefix}_renderer']();
	} else {
		setTimeout('emCommon["${prefix}_renderer"]()', 100);
	}
	
	

	</c:when>
	</c:choose>
});

//]]></script>
</c:if>