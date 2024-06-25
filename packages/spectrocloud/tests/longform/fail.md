## Debug Steps

Use the following steps to debug the issue.

1. Check the logs for any errors.

   ```shell
   palette -h work -n <namespace>
   ```

2. Check the status of the pods.

   ```shell
   kubeclt logs pod-name -n <namespace>
   ```
