##############################################################
#This module allows the creation of an action group
##############################################################

#Variable declaration for Module


#The Metric Alert rule count
variable "MatricARCount" {
  type    = "string"
  default = "18"

}

#The Metric Alert rule name
variable "MetricARName" {
  type    = "string"
  default = "MicrosoftCompute/VirtualMachine metrics"

}

#The Metric Alert rule RG
variable "MetricARRGName" {
  type    = "string"

}

#The Metric Alert rule Location
variable "MetricARLocation" {
  type    = "string"

}

#The Metric Alert rule description
variable "MetricARDesc" {
  type    = "string"
  default = "The available metric for an Azure VM"

}

#The Metric Alert rule description
variable "MetricARMetricName" {
  type    = "list"
  #Default value for Microsoft Compute VMs
  default  = [
    "Percentage CPU",
    "Network In",
    "Network Out",
    "Disk Read Bytes",
    "Disk Write Bytes",
    "Disk Read Operations/Sec",
    "Disk Write Operations/Sec",
    "CPU Credits Remaining",
    "CPU Credits Consumed",
    "Per Disk Read Bytes/sec",
    "Per Disk Write Bytes/sec",
    "Per Disk Read Operations/Sec",
    "Per Disk Write Operations/Sec",
    "Per Disk QD",
    "OS Per Disk Read Bytes/sec",
    "OS Per Disk Write Bytes/sec",
    "OS Per Disk Read Operations/Sec",
    "OS Per Disk Write Operations/Sec",
    "OS Per Disk QD	"
  ]
    
  

}

#The Metric Alert rule Operator
variable "MetricAROperator" {
  type    = "string"
  default = "Greaterthan"

}

#The Metric Alert rule Threshold
variable "MetricARThreshold" {
  type    = "list"
    default  = [
    "90",
    "1536000",
    "1536000",
    "1536000",
    "1536000",
    "100",
    "100",
    "100",
    "100",
    "100",
    "100",
    "100",
    "100",
    "100",
    "100",
    "100",
    "100",
    "100",
    "100"
  ]

}

#The Metric Alert rule period
variable "MetricARPeriod" {
  type    = "string"
  default = "PTM5"

}

#The Metric Alert rule Aggregation
variable "MetricARAggreg" {
  type    = "list"
    default  = [
    "Average",
    "Total",
    "Total",
    "Total",
    "Total",
    "Average",
    "Average",
    "Average",
    "Average",
    "Average",
    "Average",
    "Average",
    "Average",
    "Average",
    "Average",
    "Average",
    "Average",
    "Average",
    "Average"
  ]

}