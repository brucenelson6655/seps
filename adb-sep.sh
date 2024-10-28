#!/bin/bash

usage() {
        echo "./$(basename $0) -h --> shows usage"
        echo "-l location (region)"
        echo "-r resource group"
        echo "-s subscription"
        echo "-x Azure CLI login (optional)"
        exit
}

optstring=":hs:l:r:x"

if [ $# -eq 0 ] ; then 
  usage
  exit
fi

while getopts ${optstring} arg; do
  case ${arg} in
    h)
      echo "showing usage!"
      usage
      ;;
    l)
      location=$OPTARG
      ;;
    s) 
      subscription=$OPTARG
      az account set --subscription ${subscription}
      ;;
    r)
      resource_group=$OPTARG
      ;;
    x)
      az login
      ;;
    :)
      echo "$0: Must supply an argument to -$OPTARG." >&2
      exit 1
      ;;
    ?)
      echo "Invalid option: -${OPTARG}."
      exit 2
      ;;
  esac
done



sep_name=databricks-sep-${location}

artifacts="/subscriptions/d8e00388-99e2-4f9d-b8fa-ff0d4bdac2c8"
system_tables="/subscriptions/f8097f96-0d22-411a-bcfb-6cea37648007"

az network service-endpoint policy delete --name ${sep_name} --resource-group ${resource_group} --subscription ${subscription}
az network service-endpoint policy create --name ${sep_name} --resource-group ${resource_group} --location ${location} --subscription ${subscription}

az network service-endpoint policy-definition create \
--policy-name ${sep_name} \
--resource-group ${resource_group} \
--subscription ${subscription} \
--name ${sep_name}_Microsoft.Storage \
--service Microsoft.Storage \
--service-resources ${artifacts} ${system_tables}