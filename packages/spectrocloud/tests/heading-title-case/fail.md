---
sidebar_label: "Create Cluster Definition"
title: "Create Cluster Definition"
description: "Define your Edge cluster using the Edge hosts that are registered and available."
hide_table_of_contents: false
sidebar_position: 30
tags: ["edge"]
---

To complete the Edge Installation process, an Edge host must become a member of a host cluster. You can add an Edge host
to an existing Edge cluster, or you can create a new host cluster for Edge hosts and make the Edge host a member.

:::info

Procedures described on this page apply to Edge hosts with a connection to a Palette instance only. To learn how to
create a cluster using an Edge host that does not have a connection to a Palette instance (an air-gapped Edge host),
refer to [Create Cluster with Local UI](../../local-ui/cluster-management/create-cluster.md).

:::

Select the workflow that best fits your needs.

- [Create an Edge Native Host Cluster](#create-an-edge-native-host-cluster)
- [Add an Edge Host to a Host Cluster](#add-an-edge-host-to-a-host-cluster)

### OS User

### DDOS Attack

## Create an edge native host Cluster

Use the following steps to create a new host cluster so that you can add Edge hosts to the node pools.

### limitations

- In a multi-node cluster with PXK-E as its Kubernetes layer, you cannot change custom Network Interface Card (NIC).
  When you add an Edge host to such a cluster, leave the NIC field as its default value.

### Prerequisites

- One or more registered Edge host. For more information about Edge host registration, refer to
  [Edge Host Registration](./edge-host-registration.md).

- If you are using more than one Edge host to form a cluster, the hosts in the same cluster must be on the same network.

- You must ensure that the Edge hosts have stable IP addresses. You have the following options to do achieve stable IP
  addressing for Edge hosts:
  - Use static IP addresses. Contact your network administrator to assign the Edge host a static IP address.
  - Use Dynamic Host Configuration Protocol (DHCP) reservations to reserve an IP address in a DHCP network. Contact your
    network administrator to reserve IP addresses for your Edge hosts in a DHCP network.
  - Enable network overlay on your Edge cluster. Network overlay can only be enabled during cluster creation. For more
    information about network overlay, refer to [Enable Overlay Network](../../networking/vxlan-overlay.md).

### Create Cluster

1. Log in to [Palette](https://console.spectrocloud.com).

2. Navigate to the left **Main Menu** and select **Clusters**.

3. Click on **Add New Cluster**.

4. Choose **Edge Native** for the cluster type and click **Start Edge Native Configuration**.

5. Give the cluster a name, description, and tags. Click on **Next**.

6. Select a cluster profile. If you don't have a cluster profile for Edge Native, refer to the
   [Create Edge Native Cluster Profile](../model-profile.md) guide. Click on **Next** after you have selected a cluster
   profile.

7. Review your cluster profile values and make changes as needed. Click on **Next**.

8. Provide the host cluster with the Virtual IP (VIP) address used by the physical site. Ensure that this VIP is not in
   a CIDR range that cannot routed through a proxy. In addition, ensure that this VIP does not overlap with any IP
   address already used by other hosts in your network, including your Edge hosts.

You can also select any SSH keys in case you need to remote into the host cluster. You can also provide a list of
Network Time Protocol (NTP) servers. Click on **Next**.

9. The node configuration page is where you can specify what Edge hosts make up the host cluster. Assign Edge hosts to
   the **control-plane-pool** and the **worker-pool**. When you have completed configuring the node pools, click on
   **Next**.

10. (Optional) When you assign Edge hosts to node pools, you can optionally specify a static IP address for each Edge
    host. If you want to specify a static IP, toggle on **Static IP** and provide the following information:

| **Field**       | **Description**                                                                                                                     |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| IP address      | The static IP address assigned to your Edge host. This should be unique within your network.                                        |
| Default gateway | The IP address of the default gateway for your cluster network. This gateway routes traffic from your cluster to external networks. |
| Subnet mask     | The subnet mask of your cluster network. This defines the range of IP addresses within your cluster network.                        |
| DNS server      | The IP address of the DNS server your cluster uses for domain resolution.                                                           |

If certain network information is already available, the corresponding fields will be pre-populated.

11. (Optional) When you assign an Edge host to a node pool, if your Edge host has more than one NIC, you can optionally
    specify which Network Interface Controller (NIC) the Edge host will use to communicate with the cluster. When you
    select an Edge host, Palette displays a dropdown of all NICs present on the Edge host.

If the NIC is configured on the Edge host network, an IP address is displayed next to the name of the NIC. If the NIC is
not configured on the Edge host network, you can specify its IP address, default gateway, subnet mask, as well as DNS
server to configure it.
