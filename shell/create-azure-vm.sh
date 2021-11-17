#! /bin/bash

GREEN='\033[0;32m'
NC='\033[0m'

log() {
    printf "\n${GREEN}"
    echo "--------------------------------------"
    printf "${NC} $1 \n${GREEN}"
    echo "--------------------------------------"
    printf "\n${NC}"
} 

create_VM(){
    VM_NAME=$1
    VM_NSG=$VM_NAME-nsg
    VM_IMG=$2
    RG_NAME=$3
    SIZE=$4

    log "creating VM: $VM_NAME"
    if [ $VM_IMG =~ "Microsoft" ]; then
        printf "VM Name: $VM_NAME \nVM NSG: $VM_NSG \nVM Image: $VM_IMG \nRG Name: $RG_NAME \nVM Size: $SIZE"
        az vm create \
            --resource-group $RG_NAME \
            --name  $VM_NAME \
            --image $VM_IMG \
            --size $SIZE \
            --location eastus2 \
            --zone 1 \
            --admin-username azureuser \
            --admin-password $ADMIN_PASSWD 
    else
        printf "VM Name: $VM_NAME \nVM NSG: $VM_NSG \nVM Image: $VM_IMG \nRG Name: $RG_NAME \nVM Size: $SIZE"
        az vm create \
            --resource-group $RG_NAME \
            --name  $VM_NAME \
            --image $VM_IMG \
            --size $SIZE \
            --location eastus2 \
            --zone 1 \
            --admin-username azureuser \
            --ssh-key-value vm_generic.pub
    fi

}

update_NSG(){
    VM_NAME=$1
    VM_NSG=$VM_NAME-nsg
    RG_NAME=$2
    SIZE=$4
    log "Update nsg with Quartic ports"
    az network nsg rule create \
        --resource-group $RG_NAME \
        --nsg-name $VM_NSG \
        --protocol tcp \
        --priority 1000 \
        --destination-port-range 8000-9100
}

disable_bootdiagnostics(){
    VM_NAME=$1
    RG_NAME=$2
    SIZE=$4
    log "Update nsg with Quartic ports"
    az vm boot-diagnostics disable
        --ids  \
        --name \
        --resource-group $RG_NAME \
        --subscription 
}

#create_VM "test-win-10-1" "MicrosoftWindowsDesktop:Windows-10:20h2-pro-g2:latest" "rg-test" "D4s_v3"
#create_VM "dev-setup" "Canonical:UbuntuServer:18.04-LTS:latest" "development" "Standard_D2a_v4" "'cost-center=develop' 'OS=Ubuntu 18.04' 'purpose=testing'"
create_VM "GxP-VM-02" "MicrosoftWindowsServer:WindowsServer:2016-Datacenter:latest" "QA" "Standard_A8_v2"

#update_NSG "" "rg-test"
disable_bootdiagnostics "" "" ""


log "Done..."
