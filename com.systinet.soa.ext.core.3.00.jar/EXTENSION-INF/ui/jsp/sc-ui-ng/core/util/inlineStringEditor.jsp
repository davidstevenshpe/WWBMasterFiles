<%--

Parameters:

holder * - required, instance of InlineStringEditorHolder
affects - affects parameter for the Add control

 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:choose>
    <c:when test="${empty affects}"><syswf:control mode="script" action="save" caption="${prefix}save" /></c:when>
    <c:otherwise><syswf:control mode="script" action="save" caption="${prefix}save" id="save2" affects="${affects}" /></c:otherwise>
</c:choose>

<span id="${prefix}value">${holder.value}</span>

<syswf:input name="text" value="${holder}" property="value" id="${prefix}input">
    <syswf:attribute name="class">x-hidden</syswf:attribute>
</syswf:input>

<script type="text/javascript">
//<![CDATA[

attachOn('${prefix}value','click',function() {
	Ext.get('${prefix}value').hide();
	Ext.get('${prefix}input').show();
	Ext.get('${prefix}input').removeClass('x-hidden');
	Ext.get('${prefix}input').focus();
});
attachOn('${prefix}input','blur',function() {
	${prefix}save();
	Ext.get('${prefix}value').update(Ext.get('${prefix}input').dom.value);
    Ext.get('${prefix}input').hide();
    Ext.get('${prefix}input').addClass('x-hidden');
    Ext.get('${prefix}value').show();
});
Ext.onReady(function() {
    Ext.get('${prefix}value').enableDisplayMode();
    Ext.get('${prefix}input').enableDisplayMode();
    Ext.get('${prefix}input').hide();

    var width = Ext.get('${prefix}value').getComputedWidth();
    if (!width || width < 150) {
        width = 150;
    }
    
    new Ext.HP.Input({
        width: width,
        applyTo : '${prefix}input'
    });
});

//]]>
</script>