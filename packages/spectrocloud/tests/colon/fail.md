### Deploying Cluster Profile

Use the following command to remove all previous configurations:

    ```bash
    kubectl delete -f cluster-profile.yaml
    ```

    :::info

    This callout is allowed.

    :::

A few things to keep in mind before removing the cluster profile:

- The cluster profile is removed Palette

- Active clusters are not affected.

- Names starting with `project:scope` are reserved for internal use.
