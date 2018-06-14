#                                 __                 __
#    __  ______  ____ ___  ____ _/ /____  ____  ____/ /
#   / / / / __ \/ __ `__ \/ __ `/ __/ _ \/ __ \/ __  /
#  / /_/ / /_/ / / / / / / /_/ / /_/  __/ /_/ / /_/ /
#  \__, /\____/_/ /_/ /_/\__,_/\__/\___/\____/\__,_/
# /____                     matthewdavis.io, holla!
#
include .make/Makefile.inc

NS              ?= default
APP             ?= jenkins
PERSISTENT_DISK	?= $(APP)-persistent-storage
GCLOUD_SECRET	?= gcloud-jenkins
GCLOUD_KEY_FILE	?= /service_account/service_account.json
GCLOUD_PROJECT	?= streaming-platform-devqa
GCLOUD_ZONE		?= us-central1-a


## Create persistent disk
create-disk:

	gcloud compute disks create $(PERSISTENT_DISK) --zone $(GCLOUD_ZONE) --size 10

## Create secret with service_account.json for Google Cloud Platform
secret-create:

	kubectl create secret generic $(GCLOUD_SECRET) -n $(NS) --from-file service_account.json

## Retrieve temporary password from /var/jenkins_home/secrets/initialAdminPassword
password:       ; kubectl exec $(shell kubectl get pods --all-namespaces -lapp=$(APP) -o jsonpath='{.items[0].metadata.name}') -it -- cat /var/jenkins_home/secrets/initialAdminPassword

logs-init:      ; kubectl --namespace $(NS) logs -f $(shell kubectl get pods --all-namespaces -lapp=$(APP) -o jsonpath='{.items[0].metadata.name}') -c jenkins-init
logs-jenkins:   ; kubectl --namespace $(NS) logs -f $(shell kubectl get pods --all-namespaces -lapp=$(APP) -o jsonpath='{.items[0].metadata.name}') -c jenkins

## Update config.xml https://github.com/jenkinsci/oic-auth-plugin/issues/7
openid-fix:     ; kubectl exec $(shell kubectl get pods --all-namespaces -lapp=$(APP) -o jsonpath='{.items[0].metadata.name}') -it -- sed -i 's/NameField>sub/NameField>preferred_username/' /var/jenkins_home/config.xml
