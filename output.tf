output  "httpd_ip"{
value ="${google_compute_instance.vpc-1.network_interface.0.access_config.0.nat_ip}"
}
 

