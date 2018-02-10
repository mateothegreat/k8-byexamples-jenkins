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
export

## Retrieve temporary password from /var/jenkins_home/secrets/initialAdminPassword
password:       ; kubectl exec $(shell kubectl get pods --all-namespaces -lapp=$(APP) -o jsonpath='{.items[0].metadata.name}') -it -- cat /var/jenkins_home/secrets/initialAdminPassword

logs-init:      ; kubectl --namespace $(NS) logs -f $(shell kubectl get pods --all-namespaces -lapp=$(APP) -o jsonpath='{.items[0].metadata.name}') -c jenkins-init
logs-jenkins:   ; kubectl --namespace $(NS) logs -f $(shell kubectl get pods --all-namespaces -lapp=$(APP) -o jsonpath='{.items[0].metadata.name}') -c jenkins

## Update config.xml https://github.com/jenkinsci/oic-auth-plugin/issues/7
openid-fix:     ; kubectl exec $(shell kubectl get pods --all-namespaces -lapp=$(APP) -o jsonpath='{.items[0].metadata.name}') -it -- sed -i 's/NameField>sub/NameField>preferred_username/' /var/jenkins_home/config.xml
