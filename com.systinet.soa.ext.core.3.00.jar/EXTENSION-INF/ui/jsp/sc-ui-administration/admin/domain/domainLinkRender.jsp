<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<syswf:control id="domainLink" mode="anchor" caption="${caption}" targetTask="/common/domain/view">
   <syswf:param name="domainId" value="${domainId}"/>
</syswf:control>