Param([string[]]$VMhost,[string[]]$vSwitch,[string]$VlanName,[int]$VlanID,[switch]$help)

# VARIABLES
$vSphere = "127.0.0.1"
# END VARIABLES

if(!$help) {
	if(!$vSwitch) { Write-Error "No Virtual Switch provided!" ; exit 1 }
	if(!$VlanName) { Write-Error "No VLAN Name provided!" ; exit 1 }
	if(!$VlanID) { Write-Error "No VLAN ID provided!" ; exit 1 }
}

function helper() # Help function.
{
$helpstr=@"

NAME
    Add-VLAN.ps1

SYNOPSIS
    This script is used to quickly add VLANs (Virtual Machine Port Groups) to
    all Hosts in a VMware cluster or datacenter.

SYNTAX
    Add-VLAN.ps1 -VMHost <Target VMHosts> -vSwitch <Target vSwitches>
	-VlanName <Name for new VLAN> -VlanID <ID for new VLAN>

PARAMETERS
    -VMhost <Target VMHosts>
        Specifies the names of VMhosts that the command will be applied.

    -vSwitch <Target vSwitch>
        Specifies the name of the vSwitches where the VLAN will be added.

    -VlanName <Name for new VLAN>
        Specifies the name to assign to the new VLAN.
																        
    -VlanID <ID for new VLAN>
        Specifies the ID number for the new VLAN.
																			    
    -help
        Prints this help.

VERSION
    This is version 0.1.

AUTHOR
	Charles Spence IV
	STEAL Lab Manager
	cspence@unomaha.edu
	April 15, 2015

"@
$helpstr # Display help
exit
}

#############
# Begin Run #
#############

if($help) { helper } # Check for help parameter.

# Connect to vSphere server
Connect-VIServer -Server $vSphere

if( $VMHost ) {
	Get-VMHost -Name $VMHost | Get-VirtualSwitch -Name $vSwitch | New-VirtualPortGroup -Name $VlanName -VlanId $VlanID
} else {
	Get-VMHost | Get-VirtualSwitch -Name $vSwitch | New-VirtualPortGroup -Name $VlanName -VlanId $VlanID
}
