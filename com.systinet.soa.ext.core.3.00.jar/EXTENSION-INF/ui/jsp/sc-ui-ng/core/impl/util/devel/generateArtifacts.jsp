<%@page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<tr>
	<th class="UI Label Inline">
		Generator:
	</th>
	<td>
        <table>
            <tbody>
                <tr>
                    <th><label for="">Name</label></th>
                    <td><syswf:input mode="text" name="name" value="${this.data}" property="name"/></td>
                </tr>
                <tr>
                    <th><label for="">Generate names</label></th>
                    <td><syswf:selectOne name="generateNames"
                          value="${this.data}" property="generateNames" mode="checkbox" optionValues="true"
                          optionCaptions=" " dataType="boolean"/> vocabulary <syswf:input mode="text" name="namewords" value="${this.data}" property="keywords">
                    <syswf:attribute name="size" value="70" /></syswf:input></td>
                </tr>
                <tr>
                    <th><label for="">Type</label></th>
                    <td><syswf:selectOne optionValues="${this.data.values}" optionCaptions="${this.data.captions}" mode="menu" name="sdmName" value="${this.data}" property="sdmName"/></td>
                </tr>
                <tr>
                    <th><label for="">Count</label></th>
                    <td><syswf:input mode="text" name="count" value="${this.data}" property="count" dataType="int"/></td>
                </tr>
            </tbody>
        </table>
        <table>
            <tbody>
                <tr>
                    <th><label for="">Generate keywords</label></th>
                    <td><syswf:selectOne name="generateKeywords"
                          value="${this.data}" property="generateKeywords" mode="checkbox" optionValues="true"
                          optionCaptions=" " dataType="boolean"/></td>
                </tr>
                <tr>
                    <th><label for="">Keywords max count</label></th>
                    <td><syswf:input mode="text" name="keycount" value="${this.data}" property="keycount" dataType="int"/></td>
                </tr>
                <tr>
                    <th><label for="">Keywords (separate with space)</label></th>
                    <td><syswf:input mode="text" name="keywords" value="${this.data}" property="keywords">
                    <syswf:attribute name="size" value="70" />
                    </syswf:input></td>
                </tr>
            </tbody>
        </table>
        <syswf:control mode="button" action="generateArtifacts" caption="Generate"/>
	</td>
</tr>        		
