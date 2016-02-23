<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<c:if test="${mode eq 'view'}">
    <c:out value="${this.selectedHolder.label}" />
    
    <div id="${prefix}" class="UI OptionAreas">
        <c:forEach items="${this.holders}" var="entry">
            <c:set var="type" value="${entry.key}" />
            <c:set var="holder" value="${entry.value}" />
            <c:if test="${type eq this.type}">
            <div id="${prefix}_${type}" class="UI OptionArea">
                <c:if test="${not holder.days[0].noInterval}">
                <div class="UI Border">
                <table class="UI Table Properties" summary="">
                    <colgroup>
                        <col class="LabelCol"/>
                        <col />
                    </colgroup>
                    <tbody>
                        <c:forEach items="${holder.days}" var="day">
                        	<c:if test="${holder.id ne 'oneDay' || not empty day.from || not empty day.to}">
	                            <tr>
	                                <th><label class="UI Label Inline" for="${prefix}_${day.id}_start">${day.label}:</label></th>
	                                <td>
	                                    <table class="UI Table Schedule">
	                                        <col class="TimeCol" />
	                                        <col class="BreakCol" />
	                                        <col class="TimeCol" />
	                                        <tr>
	                                            <td>${day.from}</td>
	                                            <td>
	                                            	<c:if test="${not empty day.from || not empty day.to}" >
	                                            		<label class="UI Label Inline" for="${prefix}_${day.id}_end">&nbsp; - &nbsp;</label>
	                                            	</c:if>
	                                          	</td>
	                                            <td>${day.to}</td>
	                                        </tr>
	                                    </table>
	                                </td>
	                            </tr>
	                        </c:if>
                        </c:forEach>
                    </tbody>
                </table>
                </div>
                </c:if>
            </div>
            </c:if>
        </c:forEach>
    </div>
</c:if>

<c:if test="${mode eq 'edit'}">
    <syswf:selectOne id="${prefix}_type" name="type" mode="menu" value="${this}" property="type" 
            optionValues="${this.typeValues}" optionCaptions="${this.typeCaptions}" />
    <script type="text/javascript">
//<![CDATA[

        Ext.onReady( function() {
            var cmb_${prefix}_type = new Ext.form.ComboBox({
                id : '${prefix}_type',
                transform : '${prefix}_type',
                disableKeyFilter : true,
                mode : 'local',
                autoHeight : true,
                editable : false,
                resizable : true,
                listWidth : 312,
                width : 312,
                triggerAction : 'all'
            });

            cmb_${prefix}_type.on( 'select',
                function(combo,record){
                    AdvancedOptions.Form.Switch('${prefix}', '${prefix}_'+record.data.value);
                }
            );
        });
    
//]]>
</script>
    <div id="${prefix}" class="UI OptionAreas">
        <c:forEach items="${this.holders}" var="entry">
            <c:set var="type" value="${entry.key}" />
            <c:set var="holder" value="${entry.value}" />
            <div id="${prefix}_${type}" class="UI OptionArea x-hidden">
                <c:if test="${not holder.days[0].noInterval}">
                <div class="UI Border">
                <table class="UI Table Properties" summary="">
                    <colgroup>
                        <col class="LabelCol"/>
                        <col />
                    </colgroup>
                    <tbody>
                    	<c:choose>
                    		<c:when test="${holder.id eq 'oneDay'}">
                    			<c:set var="day" value="${holder.day}"/>
                   				<tr>
	                                <td>
	                                	<syswf:selectOne mode="menu" displayAsRow="true" value="${day}" property="id" 
	                                					optionValues="${this.oneDayValues}" optionCaptions="${this.oneDayCaptions}" name="oneDay" />:
	                                </td>
	                                <td>
	                                    <table class="UI Table Schedule">
	                                        <col class="TimeCol" />
	                                        <col class="BreakCol" />
	                                        <col class="TimeCol" />
	                                        <tr>
	                                            <td>
	                                                <syswf:component name="/core/impl/widget/timeCombo" prefix="${day.id}start">
	                                                    <syswf:param name="time" value="${day}" property="from"/>
	                                                </syswf:component>
	                                            </td>
	                                            <td><label class="UI Label Inline" for="${prefix}_${day.id}end">&nbsp; - &nbsp;</label></td>
	                                            <td>
	                                                <syswf:component name="/core/impl/widget/timeCombo" prefix="${day.id}end">
	                                                    <syswf:param name="time" value="${day}" property="to"/>
	                                                </syswf:component>
	                                            </td>
	                                        </tr>
	                                    </table>
	                                </td>
	                            </tr>
                    		</c:when>
                    		<c:otherwise>
		                        <c:forEach items="${holder.days}" var="day">
		                            <tr>
		                                <th><label class="UI Label Inline" for="${prefix}_${day.id}start">${day.label}:</label></th>
		                                <td>
		                                    <table class="UI Table Schedule">
		                                        <col class="TimeCol" />
		                                        <col class="BreakCol" />
		                                        <col class="TimeCol" />
		                                        <tr>
		                                            <td>
		                                                <syswf:component name="/core/impl/widget/timeCombo" prefix="${day.id}start">
		                                                    <syswf:param name="time" value="${day}" property="from"/>
		                                                </syswf:component>
		                                            </td>
		                                            <td><label class="UI Label Inline" for="${prefix}_${day.id}end">&nbsp; - &nbsp;</label></td>
		                                            <td>
		                                                <syswf:component name="/core/impl/widget/timeCombo" prefix="${day.id}end">
		                                                    <syswf:param name="time" value="${day}" property="to"/>
		                                                </syswf:component>
		                                            </td>
		                                        </tr>
		                                    </table>
		                                </td>
		                            </tr>
		                        </c:forEach>
		                    </c:otherwise>
		                </c:choose>
                    </tbody>
                </table>
                </div>
                </c:if>
            </div>
        </c:forEach>
    </div>
    <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function() {
            AdvancedOptions.Form.Switch('${prefix}', '${prefix}_${this.type}');
        });
    
//]]>
</script>
</c:if>