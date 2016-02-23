<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>


<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>



    <c:forEach items="${this.webConditions}" var="condition" varStatus="status">
    
    
        <syswf:control id="${prefix}remove${status.index}" mode="script" caption="${prefix}remove${status.index}" action="onRemove" affects=".">
            <syswf:param name="condition" value="${condition}" />
        </syswf:control>
    
        <c:set var="wrapperDivId" value="${prefix}find_address${status.index}" />
        
        <div class="Form Collection Address" id="${wrapperDivId}">
        
            <table class="UI Table Properties">
            
                <colgroup>
                    <col class="LabelCol" />
                    <col />
                    <col class="RemoveCol"/>
                </colgroup>
            
            
                <tbody>
                    <tr>
                        <th>
                            <label class="UI Label" for="recipient${status.index}"><fmt:message key="address.recipient" bundle="${widgetMessages}"/>:</label>
                        </th>
                        <td>
                            <syswf:input id="recipient${status.index}" name="recipient${status.index}"
                                value="${condition}" property="recipient">
                                <syswf:attribute name="class" value="x-form-text x-form-field" />
                            </syswf:input>
                        </td>
                        <td>
                           <syswf:component name="/core/impl/widget/search/removeLink" prefix="removeLink${status.index}" wrap="false">
                                <syswf:param name="status" value="${status}" />
                                <syswf:param name="firstRemovable" value="${this.model.firstRemovable}" />
                                <syswf:param name="condition" value="${condition}" />
                                <syswf:param name="removeFce" value="${prefix}remove${status.index}"/>
                            </syswf:component>
                        </td>
                    </tr>
            
                    <tr>
                        <th>
                            <label class="UI Label" for="recipient${status.index}"><fmt:message key="address.street" bundle="${widgetMessages}"/>:</label>
                        </th>
                        <td>
                            <syswf:input id="street${status.index}" name="street${status.index}"
                                value="${condition}" property="street">
                                <syswf:attribute name="class" value="x-form-text x-form-field" />
                            </syswf:input>
                        </td>
                        <td></td>
                    </tr>
            
                    <tr>
                        <th>
                            <label class="UI Label" for="city${status.index}"><fmt:message key="address.city" bundle="${widgetMessages}"/>:</label>
                        </th>
                        <td>
                            <syswf:input id="city${status.index}" name="city${status.index}"
                                value="${condition}" property="city">
                                <syswf:attribute name="class" value="x-form-text x-form-field" />
                            </syswf:input>
                        </td>
                        <td></td>
                    </tr>
            
                    <tr>
                        <th>
                            <label class="UI Label" for="state${status.index}"><fmt:message key="address.stateProvince" bundle="${widgetMessages}"/>:</label>
                        </th>
                        <td>
                            <syswf:input id="state${status.index}" name="state${status.index}"
                                value="${condition}" property="stateProvince">
                                <syswf:attribute name="class" value="x-form-text x-form-field" />
                             </syswf:input>
                        </td>
                        <td></td>
                    </tr>
            
                    <tr>
                        <th>
                            <label class="UI Label" for="postalCode${status.index}"><fmt:message key="address.postalCode" bundle="${widgetMessages}"/>:</label>
                        </th>
                        <td>
                            <syswf:input id="postalCode${status.index}" name="postalCode${status.index}"
                                value="${condition}" property="postalCode">
                                <syswf:attribute name="class" value="x-form-text x-form-field" />
                             </syswf:input>
                        </td>
                        <td></td>
                    </tr>
            
                    <tr>
                        <th>
                            <label class="UI Label" for="country${status.index}"><fmt:message key="address.country" bundle="${widgetMessages}"/>:</label>
                        </th>
                        <td>
                            <syswf:input id="country${status.index}" name="country${status.index}"
                                value="${condition}" property="country">
                                <syswf:attribute name="class" value="x-form-text x-form-field" />
                             </syswf:input>
                        </td>
                        <td></td>
                    </tr>
            
                    <tr>    
                        <th>
                            <label class="UI Label" for="other${status.index}"><fmt:message key="address.other" bundle="${widgetMessages}"/>:</label>
                        </th>
                        <td>
                            <syswf:input id="other${status.index}" name="other${status.index}"
                                value="${condition}" property="other">
                                <syswf:attribute name="class" value="x-form-text x-form-field" />
                             </syswf:input>
                        </td>
                        <td></td>
                    </tr>
                </tbody>
            </table>
        
            
        </div>
        
    </c:forEach>
