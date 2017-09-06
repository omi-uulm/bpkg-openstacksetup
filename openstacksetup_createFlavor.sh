#######################################
# Create OpenStack Nova Flavor (if not exist)
#
# Arguments:
#   name         Name and ID of the flavor
#   vcores       Amount of CPU cores
#   ram          MB of Memory
#   disk         GB of Disk space
#
# Returns:
#   -
#
# Author: Christopher Hauser <post@c-ha.de>
#######################################
function openstacksetup_createFlavor(){
    name=$1
    vcores=$2
    ram=$3
    disk=$4

    # create service "glance" if not exist
    flavors=$(openstack flavor list)
    if [[ $? != 0 ]]; then 
        echo "failed querying flavor list." >&2
        return 1
    fi
    if [[ $(echo "$flavors" | grep "$name") ]]; then
        echo "Flavor $name exists already"
        return 0
    else
        echo "Creating flavor $name ..."
        openstack flavor create \
            --disk $disk \
            --vcpus $vcores \
            --ram $ram \
            --id "$name" \
            "$name"
        if [[ $? != 0 ]]; then 
            echo "cannot create $name flavor" >&2
            return 1
        fi
    fi
    return 0
}

if [[ ${BASH_SOURCE[0]} != $0 ]]; then
  export -f openstacksetup_createFlavor
else
  openstacksetup_createFlavor "${@}"
  exit $?
fi