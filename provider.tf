provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.oci_user
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}

