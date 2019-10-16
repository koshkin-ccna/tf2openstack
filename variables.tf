# download openrc.sh from Horizon and grep it for credetials
# Значения переменных для доcтупа взять из файла openrc.sh,
# который можно скачать в интерфейса Horizon
# egrep "OS_USERNAME=|OS_PROJECT_NAME=|OS_USER_DOMAIN_NAME=|OS_PROJECT_DOMAIN_ID=" openrc.sh
variable "user_name" {
    description = "OS_USERNAME"  
    default = ""
    type = "string"
}
variable "tenant_name" {
    description = "OS_PROJECT_NAME"  
    default = "admin@example.cz"
    type = "string"
}
variable "password" {
    description = "OS_PASSWORD"  
    default = ""
    type = "string"
}
variable "user_domain_name" {
    description = "OS_USER_DOMAIN_NAME"  
    default = "users"
    type = "string"
}
variable "project_domain_id" {
    description = "OS_PROJECT_DOMAIN_ID"  
    default = ""
    type = "string"
}