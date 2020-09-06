#!/bin/bash
COMMAND=$1

case "$COMMAND" in
        deploy ) source .env
                export PUBSSHKEY
                ansible-playbook playbooks/configure-project.yaml
                ./deploy-vm.sh ;;

        destroy ) source config.sh
                docker_run /files/terraform "terraform destroy -auto-approve"
                rm -f deploy-vm.sh
                rm -f files/ks.cfg
                rm -f config.sh
                rm -f terraform/main.tf
                rm -f terraform/vars.tf;;    
        * ) cat <<EOT
Usage:
        vm.sh deploy
        vm.sh destroy
EOT
        exit 0;;
esac
