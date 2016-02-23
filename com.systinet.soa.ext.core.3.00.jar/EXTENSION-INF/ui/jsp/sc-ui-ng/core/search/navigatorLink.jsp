<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<syswf:control mode="anchor" caption="" targetTask="/common/navigator" targetDepth="0" id="${uuid}">
	<syswf:param name="uuid" value="${uuid}"/>
	<syswf:param name="viewId" value="navigator"/>
	<syswf:attribute name="class" value="UI PageAction Navigator Link"/>
	<syswf:attribute name="onclick" value="isNavIconClick=true; window.location=this.getAttribute('href');"/>
</syswf:control>
