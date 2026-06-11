# Description

## 1. Folder structure

```bash
├───environment
│   ├───dev/
│   │       locals.tf                       # location,env, proj,net and subnets naming and address
│   │       main.tf                         # modules deploy configuration
│   │       outputs.tf                      # receive outputs from modules
│   │       providers.tf                    # default session providers. Azure Cloud Shell
│   │       providers.tf.rename             # providers config. Local deploy
│   │       terraform.tfvars.rename         # secrets providers. Local deploy
│   │       variables.tf.rename             # secrets variables. Local deploy
│   ├───qa/pro/
│           
└───modules
    ├───container
    │       main.tf
    │       outputs.tf
    │       variables.tf
    │       
    ├───linux/..
```

## 1. Environment

* **locals.tf**: location, project, *env*, networking, tags, naming structure (*env* variable defines principal project naming)
* **main.tf**: number of instances, network config, image, size; review/change `count` and `subnet_id`

## 2. Modules
Reusable code; no modification required.

* ~~**container**~~: Disabled: require docker-hub personal key access, use your docker-hub repo :).
* **linux**: linux vm config
* **network**: vnet and subnets.
* **resource_group**: RG and locations config.
* **security**: NSG and associations, public ip, gateway
* **windows**: windows vm config

## 3. Network

* `pro`: _10.1.0.0/16_ - _spaincentral_
* `qa`: _10.2.0.0/16_ - _spaincentral_
* `dev`: _10.3.0.0/16_ - _francecentral_

## 4. resources

* Resource Group (RG) and Virtual Network (VNet)
* 3 subnets `dmz(direct internet access), srv, app`
* 1 (`count=1`) Windows Server with public RDP access [`dmz`]
* 0 (`count=0`) Linux server with public SSH access [`dmz`]
* N (`count=0`) Windows Server [`srv`]
* N  (`count=1`)Linux servers [`app`]
* Gateway for internet access: `srv,app`
* 1 (`count=0`) container with a public FQDN and a basic Python web app. (Disabled)
* Pending: ~~Private Link to Office~~

**References:**
* _spaincentral_
* _francecentral_
* _northeurope_
* _westeurope_
* _belgiumcentral_
