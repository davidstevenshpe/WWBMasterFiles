<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%--
Customizable component: manage list of feed, allow add/remove/edit feed.

Parameters:
   feeds: list of feedInfo
--%>

<fmt:setBundle basename="com.hp.systinet.report.ui.l10n.ReportMessages" var="reportMessages" />
<fmt:message var="title_label" key="feeds.field_title" bundle="${reportMessages}" />
<fmt:message var="feedUrl_label" key="feeds.field_feedUrl" bundle="${reportMessages}" />
<fmt:message var="showLastItems_label" key="feeds.field_showLastItems" bundle="${reportMessages}" />
<fmt:message var="updateInterval_label" key="feeds.field_updateInterval" bundle="${reportMessages}" />
<fmt:message var="minute_label" key="feeds.field_minute" bundle="${reportMessages}" />
<fmt:message var="addFeedAction_label" key="feeds.addFeedAction" bundle="${reportMessages}" />

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.report.reportMessages" var="reportMessages2"/>
<fmt:message var="saveCredentialTitle" key="saveCredential" bundle="${reportMessages2}"/>

<syswf:component name="/core/credstore/editCredential" prefix="saveCredential">
    <syswf:param name="openDialogFunction" value="__openCredStoreDialog" />
    <syswf:param name="winTitle" value="${saveCredentialTitle}" />
</syswf:component>

<c:forEach var="feedConfig" items="${feedConfigs}" varStatus="feedConfigStatus">
<div class="Content">
    <c:set var="editMode" value="${feedConfig.feedMode eq 'edit' or feedConfig.feedMode eq 'new'}"/>
    <c:if test="${not editMode}">
    
	    <syswf:component name="/core/feeds/feed" prefix="row${feedConfig.configId}">
	        <syswf:param name="feedInfo" value="${feedConfig.feedInfo}"/>
	    </syswf:component>
	    
	    <div class="ContentActions">
	         <syswf:control mode="ajax" caption="${prefix}edit${feedConfig.configId}" action="editFeed" id="edit${feedConfigStatus.index}">
	             <syswf:param name="configId" value="${feedConfig.configId}"/>
	         </syswf:control>
             <syswf:control mode="script" caption="${prefix}refresh${feedConfig.configId}" action="${prefix}_row${feedConfig.configId}$refreshFeed" affects="${prefix}_row${feedConfig.configId}" id="refresh${feedConfigStatus.index}"/>
             
             <syswf:control mode="ajax" caption="${prefix}remove${feedConfig.configId}" action="removeFeed" id="remove${feedConfigStatus.index}">
                 <syswf:param name="configId" value="${feedConfig.configId}"/>
             </syswf:control>    
          
             <div id="tb_editfeed${feedConfig.configId}">
             </div>
             <script type="text/javascript">
//<![CDATA[

                 Ext.onReady(function() {
                    var tb = new Ext.Toolbar({
                        hideMode:'visibility',
                        cls: 'hp-action-toolbar',
                        buttonAlign: 'right',
                        items: [{
                            text: 'Edit',
                            iconCls: 'UI ExtButton Edit',
                            handler  : function() {
                        	   ${prefix}edit${feedConfig.configId}();                       
                            }
                        }, '-', {
                            text: 'Refresh',
                            iconCls: 'UI ExtButton Refresh',
                            handler  : function() {
                        	   ${prefix}refresh${feedConfig.configId}();                                
                            }
                        }, '-', {
                            text: 'Remove',
                            iconCls: 'UI ExtButton Remove',
                            handler  : function() {
                                ${prefix}remove${feedConfig.configId}();                                
                            }
                        }]
                    });
                    tb.render('tb_editfeed${feedConfig.configId}');
                 });
             
//]]>
</script>
         </div>
	    
	</c:if>
	<c:if test="${editMode}">
        <table class="UI Table Properties">
            <col class="LabelCol">
            <col>
            <tbody><tr>
                <th>
                    <label for="${feedConfig.configId}new_feed_title">${title_label}</label>
                </th>
                <td>
                    <syswf:input id="${feedConfig.configId}new_feed_title" name="${feedConfig.configId}title" value="${feedConfig}" property="editTitle">
                        <syswf:attribute name="class" value="x-form-text UI Input x-form-field x-form-focus"></syswf:attribute>
                    </syswf:input>
                    <c:if test="${not empty feedConfig.validatorResult['title']}">
                        <em class="x-form-invalid-msg UI Invalid">
                            <span><c:out escapeXml="true" value="${feedConfig.validatorResult['title']}"/></span>
                        </em>
                    </c:if>
                    <script type="text/javascript">
//<![CDATA[

                        Ext.onReady(function() {
                           var title = new Ext.form.TextField({
                               applyTo: '${feedConfig.configId}new_feed_title',
                               width:'99%'
                           });
                        });
                    
//]]>
</script>
                </td>
            </tr>
            <tr>
                <th>
                    <label for="${feedConfig.configId}new_feed_url">${feedUrl_label}</label>
                </th>
                <td>
                    <syswf:input id="${feedConfig.configId}new_feed_url" name="${feedConfig.configId}url" value="${feedConfig}" property="editFeedUrl">
                        <syswf:attribute name="class" value="x-form-text UI Input x-form-field x-form-focus"></syswf:attribute>
                    </syswf:input>
                    <c:if test="${not empty feedConfig.validatorResult['feedUrl']}">
                        <em class="x-form-invalid-msg UI Invalid">
                            <span><c:out escapeXml="true" value="${feedConfig.validatorResult['feedUrl']}"/></span>
                        </em>
                    </c:if>
                    <script type="text/javascript">
//<![CDATA[

                        Ext.onReady(function() {
                           var url = new Ext.form.TextField({
                               applyTo: '${feedConfig.configId}new_feed_url',
                               width:'99%'
                           });
                        });
                    
//]]>
</script>
                </td>
            </tr>
            <tr>
                <th>
                    <label for="${feedConfig.configId}new_feed_displayedCount">${showLastItems_label}</label>
                </th>
                <td>
                    <syswf:input id="${feedConfig.configId}new_feed_displayedCount" name="${feedConfig.configId}displayedCount" value="${feedConfig}" property="editDisplayedCount">
                        <syswf:attribute name="class" value="x-form-text UI Input x-form-field x-form-focus"></syswf:attribute>
                    </syswf:input>                    
                    
                    <script type="text/javascript">
//<![CDATA[

                        Ext.onReady(function() {
                           new Ext.form.TextField({
                               applyTo: '${feedConfig.configId}new_feed_displayedCount',
                               width: 50
                           });
                        });
                    
//]]>
</script>
                </td>
            </tr>
            <tr>
                <th>
                    <label for="${feedConfig.configId}new_feed_update">${updateInterval_label}</label>
                </th>
                <td>
                    <syswf:input id="${feedConfig.configId}new_feed_update" name="${feedConfig.configId}new_feed_update" value="${feedConfig}" property="editReloadInterval">
                        <syswf:attribute name="class" value="x-form-text UI Input x-form-field x-form-focus"></syswf:attribute>
                    </syswf:input> ${minute_label}
                    <script type="text/javascript">
//<![CDATA[

                        Ext.onReady(function() {
                           new Ext.form.TextField({
                               applyTo: '${feedConfig.configId}new_feed_update',
                               width: 50
                           });
                        });
                    
//]]>
</script>
                </td>
            </tr>                                                                    
        </tbody>
        </table>
        
        <div class="ContentActions">
            <div id="tb_editfeed${feedConfig.configId}"></div>
            <syswf:control mode="ajax" caption="${prefix}save${feedConfig.configId}" action="saveFeed">
                 <syswf:param name="configId" value="${feedConfig.configId}"/>
             </syswf:control>
             <syswf:control mode="ajax" caption="${prefix}cancel${feedConfig.configId}" action="cancelFeed">
                 <syswf:param name="configId" value="${feedConfig.configId}"/>
             </syswf:control>
            <script type="text/javascript">
//<![CDATA[

                Ext.onReady(function() {
                   var tb = new Ext.Toolbar({
                       hideMode:'visibility',
                       cls: 'hp-action-toolbar',
                       buttonAlign: 'right',
                       items: [{
                           text: 'Save',
                           iconCls: 'UI ExtButton New',
                           handler  : function() {
                               ${prefix}save${feedConfig.configId}();                                
                           }
                       }, '-', {
                           text: 'Cancel',
                           iconCls: 'UI ExtButton Cancel',
                           handler  : function() {
                               ${prefix}cancel${feedConfig.configId}();                                
                           }
                       }]
                   }); 
                   tb.render('tb_editfeed${feedConfig.configId}');
                });
            
//]]>
</script>
        </div>
    </c:if>
</div>
</c:forEach>

<syswf:block className="UI Block Common">
    <syswf:control mode="postAnchor" caption="${addFeedAction_label}" action="addFeed">
        <syswf:attribute name="class" value="UI Icon Add"/>
    </syswf:control>
       
</syswf:block>