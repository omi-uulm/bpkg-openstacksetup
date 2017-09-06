#######################################
# Create OpenStack Endpoint (if not exist)
#
# Arguments:
#   type         Type of endpoint (e.g. "compute")
#   url_public   Url to the service of the endpoint (public)
#   url_internal Url to the service of the endpoint (internal)
#   url_admin    Url to the service of the endpoint (admin)
#
# Returns:
#   -
#
# Author: Christopher Hauser <post@c-ha.de>
#######################################
function openstacksetup_createEndpoint(){
    type=$1
    url_public=$2
    url_internal=$3
    url_admin=$4

    endpoints=$(openstack endpoint list)
    if [[ $? != 0 ]]; then 
        echo "failed querying endpoint list." >&2
        return 1
    fi
    if [[ $(echo "$endpoints" | grep "$type") ]]; then
        echo "Endpoint $type exists already"
    else
        echo "Create endpoint $type with url ${url}"
        openstack endpoint create --region $REGION $type public ${url_public}
        if [[ $? != 0 ]]; then 
            echo "cannot create endpoint public" >&2
            return 1
        fi        
        openstack endpoint create --region $REGION $type internal ${url_internal}
        if [[ $? != 0 ]]; then 
            echo "cannot create endpoint internal" >&2
            return 1
        fi        
        openstack endpoint create --region $REGION $type admin ${url_admin}
        if [[ $? != 0 ]]; then 
            echo "cannot create endpoint admin" >&2
            return 1
        fi           
    fi
    return 0
}

if [[ ${BASH_SOURCE[0]} != $0 ]]; then
  export -f openstacksetup_createEndpoint
else
  openstacksetup_createEndpoint "${@}"
  exit $?
fi
