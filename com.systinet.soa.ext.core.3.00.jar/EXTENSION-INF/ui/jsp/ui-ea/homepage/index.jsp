<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>

span.separator-top{
    display: block;
    margin: 10px 0;
}
h2{
    font-size: 30px;
    font-weight: bold;
    color: #FFF;
    text-align: center;
}
h3{
    font-size: 24px;
    font-weight: bold;
    float: left;
}
h4{
    font-size: 17px;
    padding: 0 0 0 15px;
}
h4.headerline{
    font-size: 17px;
    font-weight: bold;
    margin-bottom: 8px;
    padding-left: 0;
}
hr{
    border: 0 none;
    height: 1px;
    margin: 0;
    padding: 0;
}
.middle-content ul{
    margin: 0;
    padding: 15px;
}
ul.separator-border-white{
    border-bottom: 2px solid #fff;
}
ul.separator-border-catalog{
    border-bottom: 1px solid #2b4a7a;
}
ul.separator-border-datasources{
    border-bottom: 1px solid #017c7c;
}
ul.separator-border-administration{
    border-bottom: 1px solid #666;
}
ul.separator-border-governance{
    border-bottom: 1px solid #d0484f;
}

.middle-content	a{
    display: inline-block;
    color: #fff;
}


.home-page-tip	a{
    display: inline;
    color: darkblue;
}

.home-page-tip a:hover{
    text-decoration:underline;
}

.middle-content{
    border-top: 1px solid #fff;
    display: block;
    text-align: left;
    margin: 0 auto 0 auto;
    padding-top: 40px;
    padding-bottom: 40px;
    min-height: 750px;
}
span.eam-portfolio-box{
    border-radius: 18px;
    border-top-left-radius: 0;
    border-bottom-right-radius: 0;
    box-shadow: 5px 5px 8px 0 rgba(0, 0, 0, 0.15);
    width: 270px;
    float: left;
    height: 681px;
    margin: 0 27px 27px 0;
    position:relative;
}
span.eam-box-content{
    border: 2px solid #fff;
    border-bottom-left-radius: 14px;
    display: block;
    color: #fff;
    margin: 0 5px;
    padding: 0;
    height: 533px;
}

.middle-content a:hover {
    text-decoration:underline;
    color: white;
}

.modal-widget a:hover {
    text-decoration:underline;
    color: darkblue;
}

.modal-widget a {
    color: darkblue;
}

.middle-content .icon-field{
    background-repeat: no-repeat;
    background-position: 50% 0;
    display: block;
    height: 50px;
    height: 50px;
    margin: 30px 0 10px 0;
    padding: 0;
    cursor: pointer;
}
.icon-catalog{
    background-image: url(${webResourcePath}/skin410/img/homepage/icon-catalog.png);
}
.icon-data-sources{
    background-image: url(${webResourcePath}/skin410/img/homepage/icon-data-sources.png);
}
.icon-administration{
    background-image: url(${webResourcePath}/skin410/img/homepage/icon-administration.png);
}
.icon-governance{
    background-image: url(${webResourcePath}/skin410/img/homepage/icon-governance.png);
}

.maxlines1{
    width: 226px;
}
    /*
    Color
    Pallete
    */
.c-blue-dark{
    background-color: #2b4a7a;
}
.c-blue-in{
    background-color: #3e639d;
}
.c-green-dark{
    background-color: #017c7c;
}
.c-green-in{
    background-color: #029595;
}
.c-gray-dark{
    background-color: #666;
}
.c-gray-in{
    background-color: #757373;
}
.c-red{
    background-color: #d0484f;
}
.c-red-in{
    background-color: #e15960;
}
.hr-c-catalog-top{
    background-color: #142A4D;
}
.hr-c-catalog-bottom{
    background-color: #3f639a;
}
.hr-c-datasource-top{
    background-color: #026161;
}
.hr-c-datasource-bottom{
    background-color: #039292;
}
.hr-c-admin-top{
    background-color: #524e4e;
}
.hr-c-admin-bottom{
    background-color: #817e7e;
}
.hr-c-governance-top{
    background-color: #bb3138;
}
.hr-c-governance-bottom{
    background-color: #f47379;
}
    /* floats */
section#eam-homepage .middle-content span.eam-portfolio-box div.modal-widget span.modal-show {
    background-color: #fff;
    border: 3px solid #474545;
    border-bottom-left-radius: 18px;
    display: block;
    position: absolute;
    bottom: 0;
    min-height: 200px;
    margin: 0;
}

section#eam-homepage .middle-content span.eam-portfolio-box div.modal-widget {
    border-radius: 0 18px;
    display: block;
    height: 681px;
    left: 0;
    margin: 0;
    position: absolute;
    top: 0;
    width: 270px;
}

section#eam-homepage .middle-content span.eam-portfolio-box div.modal-widget span.modal-show-cover {
    display: block;
    background-color: #fff;
    border-radius: 0 18px;
    height: 100%;
    width: 100%;
    margin: 0;
    opacity: .6;
}

div.modal-widget span.modal-show header .close-btn {
    background: transparent url("${webResourcePath}/skin410/img/homepage/icon-close.png") 0 0;
    height: 15px;
    width: 15px;
    float: right;
    cursor: pointer;
    border:0 none;
}

div.modal-widget span.modal-show header {
    background-color: #474545;
    padding: 8px 15px;
    height: 50px;
}
div.modal-widget span.modal-show header h5 {
    display: inline-block;
    font-size: 15px;
    color: #fff;
    line-height: 15px;
    margin: 0;
    float: left;
    width: 90%;
}

</style>

<script>
    tips={};
    buildBox=function(target,content, heading) {
        return Ext4.create('Ext4.tip.ToolTip', {
            target: target,
            anchor: 'bottom',
            title:heading,
            html: null,
            closable: true,
            autoHide:false,
            showDelay:900719925474099,
            width: 400,
            contentEl: content
        });
    }

    showTip=function(id) {
        Ext4.get(id).setVisible(true);
    }
    hideTip=function(id) {
        Ext4.get(id).setVisible(false);
    }

</script>

<c:choose>
    <c:when test="${this.accessGranted}">
        <c:set var="contentWidth" value="width:1200px" />
    </c:when>
    <c:otherwise>
        <c:set var="contentWidth" value="width:900px" />
    </c:otherwise>
</c:choose>
<section id="eam-homepage">
    <div class="middle-content" style="${contentWidth}">
        <syswf:component name="/homepage/repository" prefix="repository">
            <syswf:param name="accessGranted" value="${this.accessGranted}"/>
        </syswf:component>
        <syswf:component name="/homepage/transformation" prefix="transformation">
            <syswf:param name="accessGranted" value="${this.accessGranted}"/>
        </syswf:component>
        <syswf:component name="/homepage/governance" prefix="governance">
            <syswf:param name="accessGranted" value="${this.accessGranted}"/>
        </syswf:component>
        <c:if test="${this.accessGranted}">
            <syswf:component name="/homepage/administration" prefix="administration">
            </syswf:component>
        </c:if>
    </div>
</section>
