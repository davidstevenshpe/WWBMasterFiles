<%@page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

				<tr>
					<th class="UI Label Inline">
						Widgets Configuration:
					</th>
					<td>
						<syswf:control mode="button" action="refresh.widgets" caption="Refresh" targetComponent="${prefix}"/>
					</td>
				</tr>        		
