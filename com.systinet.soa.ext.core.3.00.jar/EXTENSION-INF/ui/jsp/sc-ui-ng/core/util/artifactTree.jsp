<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--@elvariable id="prefix" type="java.lang.String"--%>
<%--@elvariable id="root" type="com.hp.systinet.sc.catalog.ArtifactTree.Node"--%>
<%--@elvariable id="funcGetChecked" type="java.lang.String"--%>
<%--@elvariable id="singleHolder" type="com.hp.systinet.sc.ui.util.ArtifactTreeComponent.SelectOne"--%>
<%--@elvariable id="preselectedSdmNames" type="java.util.List"--%>

<%--
showLoadingMaskOnClick - if true, then loadingMask is shown when clicked on node
autoHeight - if true, then the tree dialog will be resizeable dialog dynamically 
 --%>

<div id="${prefix}treeContent" class="UI Tree"></div>
<script type="text/javascript">
//<![CDATA[

var ${prefix}json = [
    <syswf:component name="/core/impl/util/artifactTreeNode" prefix="node" wrap="false">
        <syswf:param name="node" value="${root}"/>
        <syswf:param name="singleHolder" value="${singleHolder}"/>
        <syswf:param name="funcGetChecked" value="${funcGetChecked}"/>
        <syswf:param name="preselectedSdmNames" value="${preselectedSdmNames}"/>
    </syswf:component>
]
Ext.onReady(function(){
    var ${prefix}tree = new Ext.tree.TreePanel({
        id: '${prefix}tree',
        height: 400,
        autoWidth:true,
        <c:if test="${not empty autoHeight}" >autoHeight:${autoHeight},</c:if>
        useArrows:false,
        autoScroll:true,
        animate:true,
        enableDD:false,
        containerScroll: true,
        rootVisible: true,
        frame: false,
        loader: new Ext.tree.TreeLoader(),

        listeners: {
          'checkchange': function(node, checked){
            if(checked){
                node.getUI().addClass('selected');
            }else{
                node.getUI().removeClass('selected');
            }
          },
          'click': function(node, e){
        	  <c:if test="${showLoadingMaskOnClick}">
        	  if (e.target.parentNode.className == "x-tree-node-anchor")
            	  new Ext.LoadMask(${prefix}tree.getEl()).show();
        	  </c:if>
          }
        }
    });

    ${prefix}tree.setRootNode(${prefix}json[0]);

    for(var i = 1, len = ${prefix}json.length; i < len; i++) {
    	${prefix}root.appendChild(${prefix}tree.getLoader().createNode(${prefix}json[i]));
    }
    
    ${prefix}tree.render('${prefix}treeContent');
    ${prefix}tree.expandAll();

});

<c:if test="${not empty funcGetChecked}">
function ${funcGetChecked}() {
    var tree = Ext.getCmp('${prefix}tree');

    var checked = tree.getChecked();
    
    var ids = "";
    
    for (i=0; i < checked.length; i++) {
        ids += checked[i].id + ',';
    }
    return ids;
}
</c:if>

//]]>
</script>