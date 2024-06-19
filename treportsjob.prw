#include 'protheus.ch'

user function trep_job()
    local oSmartView as object
    
    //Caso n�o tenha o ambiente inicializado, se for executado dentro do Protheus pode comentar essa linha
    RpcSetEnv('T1', 'D MG 01', "admin", "1234") 

    oSmartView := totvs.framework.smartview.callSmartView():new("report_pedido_de_compra", "report")
    oSmartView:setRunInJob(.T.)
    oSmartView:setForceParams(.T.)
    oSmartView:executeSmartView()

    oSmartView:destroy()

return