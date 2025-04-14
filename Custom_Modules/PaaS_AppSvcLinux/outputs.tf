##############################################################
#Output for module


output "AppSvcSiteConfig" {
    value = [ for app in azurerm_linux_web_app.App : {
        name = app.name
        site_config = app.site_config
    }]
  
}