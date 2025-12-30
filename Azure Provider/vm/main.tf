// Let's start by creating our resource group
resource "azurerm_resource_group" "rg" {
    name = var.name_of_resource_group
    location = var.default_location
}


resource "azurerm_virtual_network" "vnet" {
  name                = "funny-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "funny-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
// Network Security Group to control the traffic
resource "azurerm_network_security_group" "nsg" {
    name = "funny_nsg_name"
    location = azurerm_resource_group.rg.location 
    resource_group_name = azurerm_resource_group.rg.name 

    // Allowing RDP traffic
    security_rule {
        name = "RDP"
        priority = 1001
        direction = "Inbound"
        access = "Allow"
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = "3389"
        source_address_prefix = "200.200.200.200" // Only allowing traffic from my extremely real external IP
        destination_address_prefix = "*"
    }

    security_rule {
        name = "HTTP"
        priority = 1002
        direction = "Inbound"
        access = "Allow"
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = "80"
        source_address_prefix = "*" // Allowing traffic from anywhere
        destination_address_prefix = "*" // Allowing traffic to any machine inside the group
    }   
}

// We need to associate the NSG with the subnet
resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}


// Creating a public IP to associate with the network interface
// So we can create our webserver (There is other services we can use for it, but this is my first example )
resource "azurerm_public_ip" "pip" {
  name = "real_${var.ip_name}" // This is other way to use variables inside strings, we can concatenate them
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Basic"
}

// On Azure, VM's need a network interface
resource "azurerm_network_interface" "nic" {
  name                = var.nic_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}


resource "azurerm_windows_virtual_machine" "vm" {
  name                = "funny-vm"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  size                = "Standard_B1s"

  admin_username = "azureuser"
  admin_password = var.admin_password

  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]

  os_disk {
    name                 = "funny-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  provision_vm_agent = true
}

// Output the public IP address of the VM
output "public_ip_address" {
  value = azurerm_public_ip.pip.ip_address
}