#######################################
# Create OpenStack Endpoint (if not exist)
#
# Arguments:
#   type         Type of endpoint (admin, internal, public)
#   url          Url to the service of the endpoint
#
# Returns:
#   -
#
# Author: Christopher Hauser <post@c-ha.de>
#######################################
function openstacksetup_createEndpoint(){
    type=$1
    url=$2

    endpoints=$(openstack endpoint list)
    if [[ $? != 0 ]]; then 
        echo "failed querying endpoint list." >&2
        return 1
    fi
    if [[ $(echo "$endpoints" | grep "$type") ]]; then
        echo "Endpoint $type exists already"
    else
        echo "Create endpoint $type with url ${url}
        openstack endpoint create --region $REGION $type public "${url}"
        if [[ $? != 0 ]]; then 
            echo "cannot create endpoint public" >&2
            return 1
        fi        
        openstack endpoint create --region $REGION $type internal "${url}"
        if [[ $? != 0 ]]; then 
            echo "cannot create endpoint internal" >&2
            return 1
        fi        
        openstack endpoint create --region $REGION $type admin "${url}"
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