<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

                 
<c:if test="${typeNestingLevel > 0}">
    <c:set var="clickable" value="Clickable" /> 
</c:if>

 <c:choose>
    <c:when test="${gecko == '1'}">
        <c:choose>
            <c:when test="${minOccurs == '0'}" >
                <c:set var="borderStyle" value="dashed black" />
            </c:when>
            <c:otherwise>
                <c:set var="borderStyle" value="solid black" />
            </c:otherwise>
        </c:choose>
        
        <c:if test="${undefined}">
            <c:set var="undefinedStyle" value=";background-color:#E94649" />
        </c:if>

        <c:choose>
            <c:when test="${maxOccurs == '1' or empty maxOccurs}">
                <table style="border:1px ${borderStyle}${undefinedStyle}" class="XSDElement ${clickable}" id="${boxid}">
                    <tr>
                        <td>${content}</td>
                    </tr>
                </table>
            </c:when>
            <c:otherwise>
                <div class="NM ${clickable}" id="${boxid}">
                    <table>
                        <col width="2px"/>
                        <col/>
                        <col width="2px"/>
                        <tbody>
                            <tr>
                                <td colspan="3" class="NoMarginNoPadding"><div align="right">&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td class="NoMarginNoPadding" style="border-top:1px ${borderStyle};border-left:1px ${borderStyle};"></td>
                                <td class="NoMarginNoPadding" style="border-top:1px ${borderStyle};"></td>
                                <td class="NoMarginNoPadding" style="border-bottom:1px ${borderStyle};border-left:1px ${borderStyle};"></td>
                            </tr>
                            <tr>
                                <td class="NoMarginNoPadding" colspan="2" style="border-left:1px ${borderStyle}">
                                    <div class="XSDMultipleElementContent">
                                        ${content}         
                                    </div>
                                </td>
                                <td class="NoMarginNoPadding" style="border-top:1px ${borderStyle};border-right:1px ${borderStyle};border-left:1px {$borderStyle};"></td>
                            </tr>
                            <tr height="2px">
                                <td height="2px" class="NoMarginNoPadding" style="border-top:1px ${borderStyle};"></td>
                                <td height="2px" class="NoMarginNoPadding" style="border-top:1px ${borderStyle};border-bottom:1px ${borderStyle};border-left:1px ${borderStyle};" ></td>
                                <td height="2px" class="NoMarginNoPadding" style="border-top:none; border-bottom:1px ${borderStyle};border-right:1px ${borderStyle};" ></td>
                            </tr>
                            <tr>
                                <td colspan="3" class="NoMarginNoPadding"><div align="right" style="font-size:10px;padding-right:5px">${minOccurs}..${maxOccurs}</div></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </c:when>
          
    <c:otherwise>
        <c:choose>
            <c:when test="${minOccurs == '0'}" >
                <c:set var="borderStyle" value="Dashed" />
            </c:when>
            <c:otherwise>
                <c:set var="borderStyle" value="Solid" />
            </c:otherwise>
        </c:choose>

        <c:choose>
            <c:when test="${maxOccurs == '1' or empty maxOccurs}">
                <table style="padding:3x 5px;" class="XSDElement ${borderStyle} ${clickable}" id="${boxid}">
                    <tr>
                        <td>${content}</td>
                    </tr>
                </table>
            </c:when>
            <c:otherwise>
                <div class="NM ${clickable}" id="${boxid}">
                    <table class="NM">
                        <col width="2px"/>
                        <col width="2px"/>
                        <col width="auto"/>
                        <col width="2px"/>
                        <tbody>
                            <tr>
                                <td width="2px" class="NoMarginNoPadding"></td>
                                <td colspan="3" class="NoMarginNoPadding"><div align="right"><xsl:text disable-output-escaping="yes">&nbsp;</xsl:text></div></td>
                            </tr>
                            <tr style="background-color:white;">
                                <td style="background-color:white;" width="2px" class="NM MultA1 ${borderStyle}"></td>
                                <td style="background-color:white;" class="NM MultA2 ${borderStyle}"></td>
                                <td style="background-color:white;" class="NM MultA3 ${borderStyle}"></td>
                                <td style="background-color:white;" class="NM MultA4 ${borderStyle}"></td>    
                            </tr>
                            <tr>
                                <td style="background-color:white;" class="NM MultB1 ${borderStyle}"/></td>
                                <td style="background-color:white;" class="NM MultB2" colspan="2">
                                    <div class="XSDMultipleElementContent">
                                        ${content}
                                    </div>
                                </td>
                                <td style="background-color:white;" class="NM MultB3 ${borderStyle}"></td>
                            </tr>
                            <tr height="2px">
                                <td style="background-color:white;" class="NM MultC1 ${borderStyle}"></td>
                                <td style="background-color:white;" height="2px" width="2px" class="NM MultC2 ${borderStyle}"></td>
                                <td style="background-color:white;" height="2px" width="auto" class="NM MultC3 ${borderStyle}"></td>
                                <td style="background-color:white;" height="2px" class="NM MultC4 ${borderStyle}"></td>
                            </tr>
                            <tr>
                                <td class="NM"></td>
                                <td colspan="3" class="NM"><div align="right" style="font-size:10px;padding-right:5px">${minOccurs}..${maxOccurs}</div></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </c:otherwise>
</c:choose>
