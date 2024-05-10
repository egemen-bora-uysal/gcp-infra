project = "foo"

region = {
  "region1" = "gcp-region1"
  #...
}

zones = {
  "region1" = ["gcp-region1-a", "gcp-region1-b", "gcp-region1-c"]
  #...
}

subnets = {
  region1 = "region1_ip/##"
  #...
  ###
  gke = "gke_ip/##"
  ###
}

foobar_configs = {
  bar = {
    machine_type = "machine-type"

    regions = {
      region1 = {
        name          = "foo-bar-region1"
        machine_image = "foo-test-region1"
        count         = 1
      }
      #...
    }
  }

}

foo_schedules = {
  first = {
    start = "% % * * *"
    end   = "% % * * *"
  }
  second = {
    start = "% % * * *"
    end   = "% % * * *"
  }
  third = {
    start = "% % * * *"
    end   = "% % * * *"
  }
}

foo-sa = "##@developer.gserviceaccount.com"

###
ip_range_pods     = "pod-secondary-range"
ip_range_services = "svc-secondary-range"

cluster_name   = "foo-gke-region1"
node_pool_name = "foo-gke-region1-pool"

master_ip_range     = "range/##"
subnet_pod_ip_range = "range/##"
subnet_svc_ip_range = "range/##"
###
