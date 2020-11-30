#  variable definitions


variable "creds" {
  type = map
  default = {
    username = "soumukhe"
    password = "sekretPass"
    url      = "https://10.1.100.94/mso/login"
    domain   = "dmzrad"
  }
}

variable "tenant_stuff" {
  type = map
  default = {
    tenant_name  = "sm-terraform-T1"
    display_name = "sm-Terraform-Tenant"
    description  = " Soumitra Terraform Created Tenant"
  }
}


variable "phy_site1_name" {
  type    = string
  default = "DMZ-RCDN-Site1"
}

variable "phy_site2_name" {
  type    = string
  default = "DMZ-RCDN-Fabric7"
}

variable "aws_site3_name" {
  type    = string
  default = "AWS-Site-2"
}

variable "user_associations" {
  type = string
  #default = "5ec379ac120000a642306d34"
  default = "5ecada3e0e0000b010518b20" # got this from manually by associating user to tenant and then doing 
  # terraform plan and then lookup the state file.  Was not able to get remote user from api calls.   Local user can be done easily with data.
}

variable "awsstuff" {
  type = map
  default = {
    aws_account_id         = "970521513280"
    is_aws_account_trusted = false
    aws_access_key_id      = "AKIA6D536CJKPCI5V5TX"
    aws_secret_key         = "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"
  }
}

variable "schema" {
  type = map
  default = {
    schema1        = "SM-Terraform-Tenant-Schema"
    template_name1 = "shared-template1"
    vrf_name1      = "vrf1"
  }
}







