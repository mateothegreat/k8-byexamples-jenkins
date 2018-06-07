<!--
#                                 __                 __
#    __  ______  ____ ___  ____ _/ /____  ____  ____/ /
#   / / / / __ \/ __ `__ \/ __ `/ __/ _ \/ __ \/ __  /
#  / /_/ / /_/ / / / / / / /_/ / /_/  __/ /_/ / /_/ /
#  \__, /\____/_/ /_/ /_/\__,_/\__/\___/\____/\__,_/
# /____                     matthewdavis.io, holla!
#
#-->

[![Clickity click](https://img.shields.io/badge/k8s%20by%20example%20yo-limit%20time-ff69b4.svg?style=flat-square)](https://k8.matthewdavis.io)
[![Twitter Follow](https://img.shields.io/twitter/follow/yomateod.svg?label=Follow&style=flat-square)](https://twitter.com/yomateod) [![Skype Contact](https://img.shields.io/badge/skype%20id-appsoa-blue.svg?style=flat-square)](skype:appsoa?chat)

#

Deploy Jenkins with a `make install`.

Don't forget to button it up with https://github.com/mateothegreat/k8-byexamples-cert-manager and get fancy with https://github.com/mateothegreat/k8-byexamples-keycloak!

## Usage

```sh
$ make help

Usage:

  make <target>

Targets:

  password             Retrieve temporary password from /var/jenkins_home/secrets/initialAdminPassword
  manifests            Output manifests detected (used with make install, delete, get, describe, etc)
  install              Installs manifests to kubernetes using kubectl apply (make manifests to see what will be installed)
  delete               Deletes manifests to kubernetes using kubectl delete (make manifests to see what will be installed)
  get                  Retrieves manifests to kubernetes using kubectl get (make manifests to see what will be installed)
  describe             Describes manifests to kubernetes using kubectl describe (make manifests to see what will be installed)
  logs                 Find first pod and follow log output
  context              Globally set the current-context (default namespace)
  shell                Grab a shell in a running container
```

## Install

```sh
$ make install

[ INSTALLING MANIFESTS/DEPLOYMENT.YAML ]: deployment "jenkins-deployment" unchanged
[ INSTALLING MANIFESTS/PERSISTENTVOLUMECLAIM.YAML ]: persistentvolumeclaim "jenkins-persistent-storage" unchanged
[ INSTALLING MANIFESTS/SERVICE.YAML ]: service "jenkins-ui" configured
```

## Get the initial password

```sh

$ make password 
kubectl exec jenkins-deployment-7449f6d84f-pkq52 -it -- cat /var/jenkins_home/secrets/initialAdminPassword

9216363c424f4effbe920f32376ee7ef

```
## Delete

```sh
$ md

[ DELETING MANIFESTS/DEPLOYMENT.YAML ]: deployment "jenkins-deployment" deleted
[ DELETING MANIFESTS/PERSISTENTVOLUMECLAIM.YAML ]: persistentvolumeclaim "jenkins-persistent-storage" deleted
[ DELETING MANIFESTS/SERVICE.YAML ]: service "jenkins-ui" deleted
```
