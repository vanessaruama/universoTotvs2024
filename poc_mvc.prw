#include "protheus.ch"
#include "fwmvcdef.ch"

//-------------------------------------------------------------------
/*/{Protheus.doc} poc_mvc
Exemplo de um modelo e view baseado em uma unica tabela com chamada
de um relatório no treports pela função totvs.framework.treports.callTReports

@author  Vanessa Ruama
@since   01/12/2022
@version 1.0
/*/
//-------------------------------------------------------------------
User Function poc_mvc()
    Local oBrowse As Object
	
	oBrowse := FWMBrowse():New()
	oBrowse:SetAlias('SC7')
	oBrowse:SetDescription('Pedido de Compras')
	oBrowse:Activate()
		
Return

//-------------------------------------------------------------------
/*/{Protheus.doc} MenuDef
Função para carregamento do menu.

@return aRotina, array, array com as opções de menu.

@author  Vanessa Ruama
@since   01/12/2022
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function MenuDef()
    Local aRotina As Array
    Local aMedicao As Array

    aRotina := {}
    aMedicao := {}

    ADD OPTION aRotina TITLE 'Visualizar'            ACTION 'VIEWDEF.poc_mvc' OPERATION 2 ACCESS 0
    ADD OPTION aRotina TITLE 'Incluir'               ACTION 'VIEWDEF.poc_mvc' OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE 'Alterar'               ACTION 'VIEWDEF.poc_mvc' OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE 'Alterar'               ACTION 'VIEWDEF.poc_mvc' OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE 'Excluir'               ACTION 'VIEWDEF.poc_mvc' OPERATION 5 ACCESS 0
    ADD OPTION aRotina TITLE 'Pedido de Compras SV'  ACTION 'u_callSV'        OPERATION 8 ACCESS 0
    ADD OPTION aRotina TITLE 'Pedido de Compras Job' ACTION 'u_callJob'       OPERATION 8 ACCESS 0
Return aRotina

//-------------------------------------------------------------------
/*/{Protheus.doc} ModelDef
Definição do model referente aos pedidos

@return oModel, objeto, objeto do modelo

@author  Vanessa Ruama
@since   01/12/2022
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function ModelDef()
    Local oModel As Object
    Local oStruSC7 As Object

    oStruSC7 := FWFormStruct(1,"SC7")

	oModel := MPFormModel():New("PEDIDO")
	oModel:SetDescription("Pedido de Compras")
	
	oModel:addFields('MASTERSC7',,oStruSC7)
	oModel:getModel('MASTERSC7'):SetDescription('Pedido de Compras')
	 
Return oModel

//-------------------------------------------------------------------
/*{Protheus.doc} ViewDef
Interface do modelo de dados

@return oView , objeto, retorna a view do modelo

@author  Vanessa Ruama
@since   01/12/2022
@version 1.0
*/
//-------------------------------------------------------------------
Static Function ViewDef()
Local oModel := ModelDef()
Local oView
Local oStrSC7:= FWFormStruct(2, 'SC7')
	
	oView := FWFormView():New()
	oView:SetModel(oModel)

	oView:AddField('FORM_PROD' , oStrSC7,'MASTERSC7' ) 
	oView:CreateHorizontalBox( 'BOX_FORM_PROD', 100)
	oView:SetOwnerView('FORM_PROD','BOX_FORM_PROD')	
	
Return oView

//-------------------------------------------------------------------
/*{Protheus.doc} callSv
Chama o relatório do Smart View

@author  Vanessa Ruama
@since   18/06/2024
@version 1.0
*/
//-------------------------------------------------------------------
user function callSv()
local oSmartView as object

oSmartView := totvs.framework.smartview.callSmartView():new("relatorio_pedido", "report")
oSmartView:executeSmartView()

oSmartView:destroy()
return

//-------------------------------------------------------------------
/*{Protheus.doc} callJob
Executa o relatório do smart view em job

@author  Vanessa Ruama
@since   18/06/2024
@version 1.0
*/
//-------------------------------------------------------------------
user function callJob()
local oSmartView as object

oSmartView := totvs.framework.smartview.callSmartView():new("relatorio_pedido", "report")
oSmartView:setParam("MV_PAR01", {"000001", "000002","000004"})
oSmartView:setForceParams(.T.)
oSmartView:setRunInJob(.T.)
oSmartView:executeSmartView()

oSmartView:destroy()
return