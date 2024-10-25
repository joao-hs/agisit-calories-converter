## Google Cloud Provider deployment utility
> Based on the lab (https://gitlab.rnl.tecnico.ulisboa.pt/agisit/agisit24/-/tree/master/labs/lab3?ref_type=heads)

This repository contains all necessary scripts, configuration files, and others, to create a successful deloyment of this application in the Google Compute Engine's virtual machines.

In case you are running this without the Virtual Box Virtual Machine defined in `agisit24-g10/vagrant`, you should still consider looking at the deployment guide in `agisit24-g10/vagrant/deploy-guide.sh`.

The deployment is mostly made to be agnostic of the replication factor of each microservice. Yet, at this time, it is not tested nor supported to be running in a replicated way due to the application level logic. Therefore, in `terraform-gcp-variables.tf`, keep the `<SERVICE>_COUNT` variable at 1.