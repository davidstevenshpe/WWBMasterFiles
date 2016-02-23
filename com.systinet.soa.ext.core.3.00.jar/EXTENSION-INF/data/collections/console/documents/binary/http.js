var httpReq;

function httpGet(url, callback) {
    try {
        document.Comm.ResponseContentType.value = ""
        document.Comm.ResponseStatusCode.value = ""; 
        document.Comm.ResponseContent.value = "HTTP GET IN PROGRESS....\n"+url
        document.Comm.ResponseRequestURI.value=url;
        if (window.XMLHttpRequest) {
        // mozilla
// for localhost debug only: netscape.security.PrivilegeManager.enablePrivilege("UniversalBrowserRead");
            httpReq = new XMLHttpRequest();
        } else {
        // IE
            try {
                httpReq = new ActiveXObject("Msxml2.XMLHTTP");
            } catch (e) {
                httpReq = new ActiveXObject("Microsoft.XMLHTTP");
            }
        }
        httpReq.onreadystatechange = callback;
        httpReq.open("GET", url, true);
        httpReq.send(null);
    } catch ( e ) {
        document.Comm.ResponseContent.value = "HTTP GET FAILED\n"+url+"\n"+e;
        document.Comm.ResponseContentType.value = "";
        alert(document.Comm.ResponseContent.value);
    }
}

function httpPost(url, data, callback, contentType) {
    try {
        document.Comm.ResponseContentType.value = ""
        document.Comm.ResponseStatusCode.value = "";
        document.Comm.ResponseContent.value = "HTTP POST IN PROGRESS....\n"+url
        document.Comm.ResponseRequestURI.value=url;
        if (window.XMLHttpRequest) {
        // mozilla
// for localhost debug only: netscape.security.PrivilegeManager.enablePrivilege("UniversalBrowserRead");
            httpReq = new XMLHttpRequest();
        } else {
        // IE
            try {
                httpReq = new ActiveXObject("Msxml2.XMLHTTP");
            } catch (e) {
                httpReq = new ActiveXObject("Microsoft.XMLHTTP");
            }
        }
        httpReq.onreadystatechange = callback;
        httpReq.open("POST", url, true);
        httpReq.setRequestHeader("Content-Type", contentType)
        httpReq.send(data);
    } catch ( e ) {
        document.Comm.ResponseContent.value = "HTTP POST FAILED\n"+url+"\n"+e;
        document.Comm.ResponseContentType.value = "";
        alert(document.Comm.ResponseContent.value);
    }
}
