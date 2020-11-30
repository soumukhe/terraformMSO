
data "mso_site" "site1" {
  name = var.phy_site1_name
}

data "mso_site" "site2" {
  name = var.phy_site2_name
}

data "mso_site" "site3" {
  name = var.aws_site3_name
}

resource "mso_tenant" "tenant" {
  name         = var.tenant_stuff.tenant_name
  display_name = var.tenant_stuff.display_name
  description  = var.tenant_stuff.description
  site_associations { site_id = data.mso_site.site1.id }
  site_associations { site_id = data.mso_site.site2.id }
  site_associations {
    site_id           = data.mso_site.site3.id
    vendor            = "aws"
    aws_account_id    = var.awsstuff.aws_account_id
    aws_access_key_id = var.awsstuff.aws_access_key_id
    aws_secret_key    = var.awsstuff.aws_secret_key
  }
  user_associations { user_id = var.user_associations } # for remote users, get userID, https://{msoIP}/mso/api/v1/tenants/allowed-users
}

resource "mso_schema" "schema1" {
  name          = var.schema.schema1
  template_name = var.schema.template_name1
  tenant_id     = mso_tenant.tenant.id
}

resource "mso_schema_site" "site1" {
  schema_id     = mso_schema.schema1.id
  site_id       = data.mso_site.site1.id
  template_name = var.schema.template_name1
}

resource "mso_schema_site" "site2" {
  schema_id     = mso_schema.schema1.id
  site_id       = data.mso_site.site2.id
  template_name = var.schema.template_name1
}


resource "mso_schema_site" "site3" {
  schema_id     = mso_schema.schema1.id
  site_id       = data.mso_site.site3.id
  template_name = var.schema.template_name1
}

#   Till here everything works well.   The MSO gets the tenant/schema/template with no issues.
#  I am unable to make a shared VRF in physical site and cloud site  or bring up a VRF in just a cloud site.  
# Below are some of the resources I've tried amongst many.



/*

resource "mso_schema_template_vrf" "vrf1" { # bombs right here complaining: VRF cannot be created on AWS Site due to region not being configured yet !
  schema_id        = mso_schema.schema1.id
  template         = var.schema.template_name1
  name             = var.schema.vrf_name1
  display_name     = var.schema.vrf_name1
  layer3_multicast = false
  vzany            = false
}


resource "mso_schema_site_vrf_region_cidr" "vrfRegionCidr" {  # this did not work either.
  schema_id = mso_schema.schema1.id
  template_name = var.schema.template_name1
  site_id = data.mso_site.site3.id
  vrf_name = var.schema.vrf_name1
  region_name = "us-east-1"
  ip = "10.140.0.0/16"
  primary = false
}


resource "mso_schema_site_vrf_region" "vrfRegion" {
  schema_id          = mso_schema.schema1.id
  template_name      = var.schema.template_name1
  site_id            = data.mso_site.site3.id
  vrf_name           = var.schema.vrf_name1
  region_name        = "us-east-1"
  vpn_gateway        = false
  hub_network_enable = true
  hub_network = {
    name        = "TGW"
    tenant_name = "infra"
  }
  cidr {
    cidr_ip = "10.140.0.0/16"
    primary = true
    subnet {
      ip   = "10.140.1.0/24"
      zone = "us-east-1a"
      #usage = "sdfkhsdkf"
    }
  }
}
*/
