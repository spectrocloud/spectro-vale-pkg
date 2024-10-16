## Create Infrastructure Profile

1. Log in to [Palette](https://console.spectrocloud.com/).

2. From the left **Main Menu** click **Profiles**.

3. Click on the **Add Cluster Profile** button.

4. Fill out the following input values and ensure you select **Infrastructure** for the type. Click on **Next** to
   continue.

   | **Field**       | **Description**                                                                                                                                                                                                   |
   | --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
   | **Name**        | A custom name for the profile.                                                                                                                                                                                    |
   | **Version**     | You only need to specify a version if you create multiple versions of a profile using the same profile name. Default: `1.0.0`.                                                                                    |
   | **Description** | Use the description to provide context about the profile.                                                                                                                                                         |
   | **Type**        | **Infrastructure**                                                                                                                                                                                                |
   | **Tags**        | Assign any desired profile tags. Tags propagate to the Virtual Machines (VMs) deployed in the cloud or data center environment when clusters are created from this cluster profile. Example: `owner` or `region`. |

5. You should have 10 layers in your profile. 