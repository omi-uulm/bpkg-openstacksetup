# bpkg-openstacksetup - a bpkg package for helper functions to set up openstack

This repository is meant to be a package for the [bpkg bash package manager](http://www.bpkg.io/).

The functions offered by bpkg-openstacksetup are recurring tasks while setting up an openstack setup:

- create endpoint (if not exist)
- create service (if not exist)
- create user as admin (if not exist)
- create flavor (if not exist)

## Installation

 1. Clone this repository and source the files directly, or
 2. Use the bpkg bash package manager: `bpkg install omi-uulm/bpkg-openstacksetup`

To install bpkg, run `curl -sLo- http://get.bpkg.io | bash`.

## Usage

When installed, the functions are available in `deps/bpkg-openstacksetup` and can be sourced in scripts, e.g.:

```
#!/bin/bash
source deps/bpkg-openstacksetup/openstacksetup_createService.sh
openstacksetup_createService "image" "glance" "OpenStack Image"
```