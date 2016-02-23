<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<syswf:selectOne
                id="${prefix}roleSelectorWidget" name="roleSelectorWidget"
                mode="menu"
                value="${this}" property="selectedRole"
                optionValues="${this.roleValues}" optionCaptions="${this.roleCaptions}"
                />
        <script type="text/javascript">
//<![CDATA[


            Ext.onReady( function() {
                var cmb = new Ext.form.ComboBox({
                    id : '<c:out value="${prefix}roleSelectorWidget" />',
                    transform : '<c:out value="${prefix}roleSelectorWidget" />',
                    disableKeyFilter : true,
                    mode : 'local',
                    autoHeight : true,
                    resizable : true,
                    listWidth : 300,
                    width : 300,
                    triggerAction : 'all',
                    editable : false
                });
                <c:if test="${not empty onSelectAction}">
                    cmb.on('select', ${onSelectAction});
                </c:if>
            });

//]]>
</script>