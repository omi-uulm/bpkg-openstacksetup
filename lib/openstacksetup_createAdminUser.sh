#######################################
# Create OpenStack user as admin (if not exist)
#
# Arguments:
#   name         Name of the user to create
#   pass         The password for the user
#
# Returns:
#   -
#
# Author: Christopher Hauser <post@c-ha.de>
#######################################
function openstacksetup_createAdminUser(){
    name=$1
    pass=$2

    users=$(openstack user list)
    if [[ $? != 0 ]]; then 
        echo "failed querying user list." >&2
        return 1
    fi
    if [[ $(echo "$users" | grep "$name") ]]; then
        echo "user $name already exists"
        return 0
    else
        echo "Create user $name"
        openstack user create --domain default --password=$pass $name
        if [[ $? != 0 ]]; then 
            echo "cannot create user $name" >&2
            return 1
        fi
        openstack role add --project service --user $name admin
        if [[ $? != 0 ]]; then 
            echo "cannot add admin role to user $name" >&2
            return 1
        fi
    fi
    return 0
}

if [[ ${BASH_SOURCE[0]} != $0 ]]; then
  export -f openstacksetup_createAdminUser
else
  openstacksetup_createAdminUser "${@}"
  exit $?
fi