output "web_private_ip_list" {
    description = "Web linux VM Private IP"
    value = values[{for vm in azurerm_linux_virtual_machine.web_linux_vm: vm.private_ip_address}]
}

output "web_vm_list" {
    description = "Web linux VM Name"
    value = values[{for vm in azurerm_linux_virtual_machine.web_linux_vm: vm.Name}]
}