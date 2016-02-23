<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>

<c:set var="polymorph">
                <c:if test="${not empty this.propertyPolymorphism}">
                  var setDefinedIf=function(value) {
                    var f=false;
                    <c:forEach var="val" items="${this.propertyPolymorphismKeys}">
                      <c:if test="${not(val eq 'UNUSED_TAXONOMY_VALUE')}">
                      if(value=='${val}') {
                          <c:forEach var="prop" items="${this.propertyList}">
                            var e=Ext.get('${prop}');
                            if(e!=null) {
                              e.setVisibilityMode(Ext.Element.DISPLAY);
                              e.setVisible(${this.propertyPolymorphism[val][prop]});
                              f=true;
                            }
                          </c:forEach>
                      }
                      </c:if>
                    </c:forEach>
                    if (!f) {
                          <c:forEach var="prop" items="${this.propertyList}">
                            var e=Ext.get('${prop}');
                            if(e!=null) {
                              e.setVisibilityMode(Ext.Element.DISPLAY);
                              e.setVisible(${this.propertyPolymorphism['UNUSED_TAXONOMY_VALUE'][prop]});
                            }
                          </c:forEach>
                    }
                  }
                 </c:if>
</c:set>


<c:choose>
    <c:when test="${mode eq 'view' || mode eq 'table' || this.hierarchical || this.multiple}">
    	
    	<c:if test="${mode eq 'view' and fn:length(this.categories) == 0}">
    		N/A
    	</c:if>
    
        <c:forEach items="${this.categories}" var="category" varStatus="stat">
            <%-- settings as variable to ensure there is no space before comma --%>
            <c:set var="itemValue">
            	<c:choose>
            		<c:when test="${category.error}">
            			<fmt:message var="categoryNotFound" key="category.categoryNotFound" bundle="${widgetMessages}">
							<fmt:param><c:out value="'${category.displayValue}'"/></fmt:param>
						</fmt:message>
                  		<span title="${categoryNotFound}" class="x-form-invalid-msg UI Invalid"><c:out value="${category.displayValue}"/></span>
            		</c:when>
					<c:when test="${mode eq 'table'}">
					<span title="<c:out value="${category.displayValue}"/>"><c:out value="${category.category.name}"/></span>
					</c:when>
            		<c:otherwise>
            			<c:out value="${category.displayValue}" />
            		</c:otherwise>
            	</c:choose>

                <c:if test="${mode eq 'edit' and not (this.required and not this.multiple)}">
                    <syswf:control id="remove${category.category.val}" mode="anchor" action="remove" caption="Delete" wrapper="span">
                        <syswf:param name="categoryVal" value="${category.category.val}"/>
                        <syswf:attribute name="class" value="UI Icon Delete Context"/>
                    </syswf:control>
                </c:if>
            </c:set>

            <c:set var="separator">
                <c:choose>
                    <c:when test="${category.showParents}"><br/></c:when>
                    <c:when test="${mode eq 'edit'}">&nbsp;&nbsp;</c:when>
                    <c:when test="${not stat.last}">,</c:when>
                </c:choose>
            </c:set>

            <c:out value="${itemValue}" escapeXml="false"/>${separator}
            <c:if test="${(not empty this.propertyPolymorphism) and (mode eq 'view') }">
              <script>
                <c:out value="${polymorph}" escapeXml="false"/>
                setDefinedIf('${category.category.val}');
              </script>
            </c:if>

        </c:forEach>
        <c:if test="${mode eq 'edit'}">
        	<span>
	            <syswf:component name="/core/impl/widget/util/taxonomyBrowserButton" prefix="addbut" wrap="false">
	                <syswf:param name="selectedCategories" value="${this.categories}"></syswf:param>
	                <syswf:param name="taxonomyBrowserListener" value="${this}"></syswf:param>
	                <syswf:param name="hiddenShowAllTaxonomies" value="true" />
	                <syswf:param name="singleSelection" value="${not this.multiple}" />
	                <syswf:param name="buttonText" value="Add"/>
	                <syswf:param name="preSelectedTaxonomy" value="${this.taxonomyRow}"/>
	            </syswf:component>
            </span>
        </c:if>
    </c:when>
    <c:when test="${mode eq 'edit'}">
        <syswf:selectOne
                id="${prefix}categoryWidget" name="categoryWidget"
                mode="menu"
                value="${this}" property="singleCategoryValue"
                optionValues="${this.values}" optionCaptions="${this.captions}"
                />
        <script type="text/javascript">
//<![CDATA[


            Ext.onReady( function() {
                var cmb = new Ext.form.ComboBox({
                    id : '<c:out value="${prefix}categoryWidget" />',
                    transform : '<c:out value="${prefix}categoryWidget" />',
                    disableKeyFilter : true,
                    mode : 'local',
                    autoHeight : true,
                    resizable : true,
                    listWidth : 300,
                    width : 300,
                    triggerAction : 'all',
                    editable : false,
					disabled : <c:out value="${this.disabled}"/>					
                });
                <c:if test="${not empty onSelectAction}">
                    cmb.on('select', ${onSelectAction});
                </c:if>

                <c:if test="${not empty this.propertyPolymorphism}">
                   <c:out value="${polymorph}" escapeXml="false"/>
                   cmb.on('select', function(combo,record) { setDefinedIf(combo.getValue()); });
                   setDefinedIf('${this.singleCategoryValue}');
                </c:if>
                
                <c:if test="${this.autoNaming}">					
	                var currentName = nameButton.getValue();					
					if(cmb.getValue() != "undefinedValue"){						
						nameButton.setValue(currentName + " for FY" + cmb.getValue());		
					}else{
						nameButton.setValue(currentName);
					}					
					cmb.on('select', function(combo,record) { 			
						if(cmb.getValue() != "undefinedValue"){						
							nameButton.setValue(currentName + " for FY" + cmb.getValue());		
						}else{
							nameButton.setValue(currentName);
						}											
					});
				</c:if>

            });

//]]>
</script>
    </c:when>
</c:choose>