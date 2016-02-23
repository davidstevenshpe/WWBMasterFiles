<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${this.typeCount>1}">

    <table class="UI Table Properties">
        <colgroup><col class="LabelCol">
            <col>
        </colgroup><tbody><tr>
        <th><label class="UI Label Required Full" title="Artifact Type"> Type:</label>
            <sup class="Required" title="Required">*</sup></th>
        <td>
            <div id="customTplCombo"></div>
        </td>
    </tr>
    </tbody>
    </table>

    <script>
        var types=<c:out value="${this.artifacts}" escapeXml="false"/>;

        Ext4.onReady(function() {

            Ext4.regModel('Type', {
                fields: [
                    {type: 'boolean', name: 'isAbstract'},
                    {type: 'string', name: 'sdmName'},
                    {type: 'string', name: 'label'},
                    {type: 'string', name: 'spacer'}
                ]
            });

            var store = Ext4.create('Ext4.data.Store', {
                model: 'Type',
                data: types
            });

            var customTplCombo = Ext4.create('Ext4.form.field.ComboBox', {
                renderTo: 'customTplCombo',
                displayField: 'label',
                valueField:'sdmName',
                value:'${this.currentType}',
                editable:false,
                width: 300,
                store: store,
                queryMode: 'local',
                listConfig: {
                    itemTpl: '<tpl if="isAbstract"><i></tpl>{spacer}{label}<tpl if="isAbstract"></i></tpl>'
                },
                listeners: {
                    select : function (combo,records,eopts)
                    {
                        if(records[0].get('isAbstract')) {
                            combo.setValue('${this.currentType}');
                        }
                        else
                        {
                            Ext4.get('redirectTypeValue').dom.value=(records[0].get('sdmName'));
                            changeType();
                        }
                    }
                }
            });

        });

    </script>
    <syswf:input id="redirectTypeValue" name="redirectType" value="${this}" property="redirectType" mode="hidden"/>
    <syswf:control id="redirectType" mode="script" caption="changeType" action="redirectToDifferentArtifact">
    </syswf:control>

</c:if>
