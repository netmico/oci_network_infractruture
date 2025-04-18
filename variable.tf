variable "ssh_public_keys" {
  description = "The path to the SSH public key file"
  type        = string
  default     = "~/.oci/oci_api_key_public.pem"
}

variable "oci_user" {
  description = "The OCID of the user"
  type        = string
}

variable "fingerprint" {
  description = "The fingerprint for the user's API key"
  type        = string
}

variable "private_key_path" {
  description = "The path to the private key file"
  type        = string
}

variable "region" {
  description = "The region to use"
  type        = string
}

variable "compartment_id" {
  description = "The OCID of the compartment where resources will be created"
  type        = string
}

variable "tenancy_ocid" {
  description = "The OCID of the tenancy"
  type        = string
}

variable "availability_domain" {
  description = "The availability domain to use"
  type        = string
}

variable "instance_display_name" {
  description = "The display name of the instance"
  type        = string
}

variable "shape" {
  description = "The shape of the instance"
  type        = string
}

variable "source_ocid" {
  description = "The OCID of the image to use for the instance"
  type        = string
}

variable "subnet_ocids" {
  description = "The OCIDs of the subnets to use for the instance"
  type        = list(string)
}

variable "instance_count" {
  description = "The number of instances to create"
  type        = number
  default     = 1
}

variable "boot_volume_backup_policy" {
  description = "The backup policy for the boot volume (disabled, gold, silver, or bronze)"
  type        = string
}

variable "instance_state" {
  description = "The initial state of the instance (RUNNING or STOPPED)"
  type        = string
}

variable "public_ip" {
  description = "Public IP assignment type (NONE, RESERVED, or EPHEMERAL)"
  type        = string
}

variable "image_id" {
  description = "The OCID of the image to use for the instance"
  type        = string
}

variable "block_storage_sizes_in_gbs" {
  description = "The size of the block storage in GB"
  type        = list(number)
}

variable "boot_volume_backup_policy_id" {
  description = "The OCID of the boot volume backup policy"
  type        = string
}


variable "image_ocid" {
  description = "The OCID of the image to use for the instance."
  type        = string
}




