<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<c:if test="${not empty this.invalidRelationships.relationships}">

    <div id="invalidUnhideMessage">
        <i style="font-size:12px">There are relationships that are not compliant with the current data model.
            <a href="#" onclick="openHiddenInvalidRelationships();">Show them...</a></i>
    </div>


    <div id="invalidContent" style="display: none">
        <div class="Title">
            <h3><span class="IconAlign">Non-compliant Relationships</span></h3>
        </div>
        <i style="font-size:12px">There are relationships that are not compliant with the current data model. By using those you risk
            that certain reports won't work correctly. To handle this, you can:
            <br/><br/>
            <ul>
                <li>1. Re-enter those into the system properly while following the current model.</li>
                <li>2. Declare this kind of relationship as a <syswf:control id="gov0" mode="anchor" caption="shortcut" targetTask="/admin/shortcut/homepage"/> if you
                    want to keep them in the repository as is.</li>
            </ul>
            <br/>
            <a href="#" onclick="hideInvalidRelationships();">Hide them for now...</a>
            <br/>
            <br/>
        </i>
        <c:forEach var="item" items="${this.invalidRelationships.linkedTypes}" varStatus="status">
            <syswf:component name="/core/layout/relationshipItemComponent" prefix="${prefix}${status.index}ItemComponentId">
                <syswf:param name="relationshipName" value="${item.key}" />
                <syswf:param name="artifactTypes" value="${item.value}" />
                <syswf:param name="readOnly" value="${readOnly}" />
                <syswf:param name="deleteOnly" value="${deleteOnly}" />
                <syswf:param name="isInvalid" value="${isInvalid}" />
                <syswf:param name="hasWritePermission" value="${hasWritePermission}" />
                <syswf:param name="artifact" value="${artifact}" />
            </syswf:component>
        </c:forEach>
    </div>

    <script>

        openHiddenInvalidRelationships = function() {
            Ext4.get('invalidContent').setVisibilityMode(Ext4.dom.Element.DISPLAY);
            Ext4.get('invalidUnhideMessage').setVisibilityMode(Ext4.dom.Element.DISPLAY);
            Ext4.get('invalidUnhideMessage').setVisible(false,true);
            Ext4.get('invalidContent').setVisible(true,true);
        }

        hideInvalidRelationships = function() {
            Ext4.get('invalidUnhideMessage').setVisible(true,true);
            Ext4.get('invalidContent').setVisible(false,true);
        }

    </script>


</c:if>