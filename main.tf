data "oci_identity_availability_domains" "ADs" {
  compartment_id = var.compartment_id
}


resource "oci_core_vcn" "OCI_NET" {
  cidr_block     = "10.92.0.0/16"
  compartment_id = var.compartment_id
  display_name   = "OCI_VCN"
  dns_label      = "myvcn"
}


resource "oci_core_subnet" "public" {
  cidr_block                 = "10.92.1.0/24"
  display_name               = "PublicSubnet"
  dns_label                  = "public"
  vcn_id                     = oci_core_vcn.OCI_NET.id
  compartment_id             = var.compartment_id
  availability_domain        = data.oci_identity_availability_domains.ADs.availability_domains[0].name
  security_list_ids          = [oci_core_security_list.security_list.id]
  route_table_id             = oci_core_route_table.rt.id
  prohibit_public_ip_on_vnic = false
}


resource "oci_core_subnet" "private" {
  cidr_block          = "10.92.2.0/24"
  display_name        = "PeivateSubnet"
  vcn_id              = oci_core_vcn.OCI_NET.id
  compartment_id      = var.compartment_id
  availability_domain = data.oci_identity_availability_domains.ADs.availability_domains[0].name
  security_list_ids   = [oci_core_security_list.security_list.id]

}

resource "oci_core_route_table" "rt" {
  vcn_id         = oci_core_vcn.OCI_NET.id
  compartment_id = var.compartment_id
  route_rules {

    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.igw.id

  }


}

resource "oci_core_internet_gateway" "igw" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.OCI_NET.id
  display_name   = "internet_gateway"

}

resource "oci_core_security_list" "security_list" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.OCI_NET.id

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"
    tcp_options {
      min = 22
      max = 22
    }
  }
  ingress_security_rules {
    protocol    = "6" # TCP
    source      = "10.92.2.0/24"
    source_type = "CIDR_BLOCK"
    tcp_options {
      min = 22
      max = 22
    }
  }

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }

  display_name = "vnc_security_list"
}

resource "oci_core_instance" "instance" {
  availability_domain = data.oci_identity_availability_domains.ADs.availability_domains[0].name
  compartment_id      = var.compartment_id
  display_name        = "devmlab"
  shape               = "VM.Standard2.1"
  source_details {
    source_type = "image"
    source_id   = "ocid1.image.oc1.iad.aaaaaaaablkb5j2kdyqehb7qp2scdyuwslknidn4a53qzje2fxcbw3ji5gta" # Replace with a valid image OCID
  }
  create_vnic_details {
    subnet_id = oci_core_subnet.public.id
    assign_public_ip = true
  }
}