filebeat.config:
  inputs:
    # Mounted `filebeat-inputs` configmap:
    path: $${path.config}/inputs.d/*.yml
    # Reload inputs configs as they change:
    reload.enabled: false
  modules:
    path: $${path.config}/modules.d/*.yml
    # Reload module configs as they change:
    reload.enabled: false

# To enable hints based autodiscover, remove `filebeat.config.inputs` configuration and uncomment this:
#filebeat.autodiscover:
#  providers:
#    - type: kubernetes
#      hints.enabled: true

processors:
  - add_cloud_metadata:
  - add_host_metadata:

output.logstash:
  hosts: ['${elksrv_private_ip}:5044']
  index: "${k8s_cluster_name}"
