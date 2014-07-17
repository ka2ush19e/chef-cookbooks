#---------------------------------------------------------------------------
#   Java
#---------------------------------------------------------------------------
default[:java][:install_flavor] = "openjdk"
default[:java][:jdk_version]    = "7"


#---------------------------------------------------------------------------
#   Presto Server
#---------------------------------------------------------------------------
# Paths
default.presto[:path][:conf] = "/opt/presto-server/etc"
default.presto[:path][:data] = "/var/presto-server/data"

# Node
default.presto[:node][:env] = "production"
default.presto[:node][:id]  = "ffffffff-ffff-ffff-ffff-ffffffffffff"

# JVM
default.presto[:jvm][:xmx]                      = "16G"
default.presto[:jvm][:perm_size]                = "150M"
default.presto[:jvm][:max_perm_size]            = "150M"
default.presto[:jvm][:reserved_code_cache_size] = "150M"

# Config
default.presto[:config][:type]            = "pseudo"
default.presto[:config][:http_port]       = "8080"
default.presto[:config][:task_max_memory] = "1GB"
default.presto[:config][:discovery_uri]   = "http://127.0.0.1:8080"

# Log
default.presto[:log][:level] = "INFO"

