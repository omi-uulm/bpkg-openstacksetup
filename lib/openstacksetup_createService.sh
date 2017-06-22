#######################################
# Create OpenStack Service (if not exist)
#
# Arguments:
#   type         Type of the service (e.g. compute)
#   name         Name of the service (e.g. nova)
#   description  Description of the service
#
# Returns:
#   -
#
# Author: Christopher Hauser <post@c-ha.de>
#######################################
function openstacksetup_createService(){
    type=$1
    name=$2
    description=$3

    # create service "glance" if not exist
    services=$(openstack service list)
    if [[ $? != 0 ]]; then 
        echo "failed querying service list." >&2
        return 1
    fi
    if [[ $(echo "$services" | grep "$type") ]]; then
        echo "Service $name exists already"
        return 0
    else
        echo "Creating service $name ..."
        openstack service create --name $name --description "$description" $type
        if [[ $? != 0 ]]; then 
            echo "cannot create $name service" >&2
            return 1
        fi
    fi
    return 0
}

if [[ ${BASH_SOURCE[0]} != $0 ]]; then
  export -f openstacksetup_createService
else
  openstacksetup_createService "${@}"
  exit $?
fi