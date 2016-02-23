<br/>

<div id="unhideMessage" style="display:none">
    <i style="font-size:12px">There are additional rarely used relationship types that are not defined on this artifact yet. <a href="#" onclick="openHiddenRelationships();">Show them all...</a></i>
</div>

<div id="hideMessage" style="display:none">
    <i style="font-size:12px">There are rarely used relationship types that are not defined on this artifact yet. <a href="#" onclick="hideRelationships();">Hide them...</a></i>
</div>

<script>
    if (typeof(HIDDEN_EDITORS)=='undefined') {
        HIDDEN_EDITORS=new Array();
        // editors from simpleRelationWidget & relationshipItemComponent
    }
    if(HIDDEN_EDITORS.length>0) {
        Ext4.get('unhideMessage').setVisible(true,true);
    }

    openHiddenRelationships = function() {
        Ext4.get('unhideMessage').setVisible(false,true);
        Ext4.get('hideMessage').setVisible(true,true);
        for(var i=0;i<HIDDEN_EDITORS.length;i++) {
            Ext4.get(HIDDEN_EDITORS[i]).setVisible(true,true);
        }
    }

    hideRelationships = function() {
        Ext4.get('unhideMessage').setVisible(true,true);
        Ext4.get('hideMessage').setVisibilityMode(Ext4.dom.Element.DISPLAY);
        Ext4.get('hideMessage').setVisible(false,true);
        for(var i=0;i<HIDDEN_EDITORS.length;i++) {
            Ext4.get(HIDDEN_EDITORS[i]).setVisibilityMode(Ext4.dom.Element.DISPLAY);
            Ext4.get(HIDDEN_EDITORS[i]).setVisible(false,true);
        }
    }

</script>

