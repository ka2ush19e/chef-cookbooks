default[:java][:install_flavor] = "openjdk"
default[:java][:jdk_version]    = "7"

default[:elasticsearch][:plugins] = {
  "analysis-kuromoji" => "elasticsearch/elasticsearch-analysis-kuromoji/2.0.0",
  "head"              => "mobz/elasticsearch-head",
  "HQ"                => "royrusso/elasticsearch-HQ",
  "inquisitor"        => "polyfractal/elasticsearch-inquisitor",
  "marvel"            => "elasticsearch/marvel/latest"
}
