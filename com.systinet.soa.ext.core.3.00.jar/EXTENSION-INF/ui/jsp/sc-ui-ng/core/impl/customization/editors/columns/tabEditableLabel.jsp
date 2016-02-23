<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.util.utilmessages" var="bundle"/>

<syswf:control mode="script" action="update" caption="${prefix}_update"  loadingMask="true"/>
<syswf:input id="${prefix}_updated_id" name="updatedId" value="${value.id}" mode="hidden"/>
<syswf:input id="${prefix}_updated_value" name="updatedValue" value="" mode="hidden"/>

<script type="text/javascript">
//<![CDATA[

function ${prefix}_handle_update(value) {
    var elementValue = Ext.get('${prefix}_updated_value');
    elementValue.dom.value = value;
    ${prefix}_update();        
}

//]]>
</script>

<%--
<syswf:input value="${value}" property="label" name="name" hint="${value.label}">
    <syswf:attribute name="class">UI Form ${editableLabelClass}</syswf:attribute>
</syswf:input>
<input type="text" value="${value.label}" name="name" title="${value.label}" class="UI Form ${editableLabelClass}" readonly="readonly">
--%>

<c:if test="${value.editableLabel}">
    <label id="${prefix}_label" class="UI Form Label Inline EditableLabelStatic" ><c:out value="${value.label}" /></label>
    <input id="${prefix}_input" type="text" name="name" value="<c:out value="${value.label}" />" class="UI Form EditableLabel x-hidden" readonly="readonly"/>
</c:if>
<c:if test="${not value.editableLabel}">
    <span class="UI Form EditableLabelDisabled"><c:out value="${value.label}" /></span>
</c:if>


<script type="text/javascript">
//<![CDATA[

$(document).ready(function(){
    
	<%--
    $('#${prefix}_input').closest('TD').attr('title', '<fmt:message key="editableLabel.hint" bundle="${bundle}"/>');
    --%>
    
	<%-- This function stops events beyond the element
	     We do this to stop selection of the row when the tab name is clicked. --%>
    //$('#${prefix}_label').bind('click',function(){return false;});
    $('#${prefix}_input').bind('click',function(){return false;});

    <%-- Data of the input have changed --%>
    $('#${prefix}_input').bind('change',function(){
        var newValue    = $(this).val();        <%-- get the new, changed value --%>

        <%-- set the data as new caption of the label
             and switch back the input to label --%>

        $('#${prefix}_label').html(newValue);
        $('#${prefix}_label').removeClass('x-hidden');
        $(this).addClass('x-hidden');
        
        ${prefix}_handle_update(newValue);
        $(this).removeClass('Active');
    });

    <%-- Data of the input have changed --%>
    $('#${prefix}_input').bind('keydown',function(event){
        if(event.keyCode == 13) {
            var newValue    = $(this).val();        // get the new, changed value

            <%-- set the data as new caption of the label
                 and switch back the input to label  --%>
            $('#${prefix}_label').html(newValue);
            $('#${prefix}_label').removeClass('x-hidden');
            $(this).addClass('x-hidden');
            ${prefix}_handle_update(newValue);
            $(this).removeClass('Active');
        }
    });

    <%-- Single click does nothing, just selects the row --%>
    $('#${prefix}_label').bind('click',function(){
        if(!$(this).hasClass('Active')) {$(this).blur();}
    });

    <%-- Turn into editable field on doubleclick --%>
    <%--
    $('#${prefix}_label').bind('dblclick',function(){
        $('#${prefix}_input').removeClass('x-hidden');
        $('#${prefix}_input').removeAttr('readonly');
        $('#${prefix}_input').addClass('Active');
        $('#${prefix}_input').focus();
        
        $(this).addClass('x-hidden');
    });
    --%>

	<%-- Remove the outline when losing focus --%>
    $('#${prefix}_input').bind('blur',function(){
        $('#${prefix}_label').removeClass('x-hidden');
		$(this).addClass('x-hidden');
    });
    
});

//]]>
</script>