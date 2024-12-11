[![semantic-release: angular](https://img.shields.io/badge/semantic--release-angular-e10079?logo=semantic-release)](https://github.com/semantic-release/semantic-release)

# Spectro Cloud Vale Package

![Spectro Cloud logo with docs inline](/static/images/spectrocloud-logo-light.svg)

This repository contains the Vale package for Spectro Cloud documentation. The package includes custom rules and configurations to ensure consistency and quality across the documentation. It is based on the [Spectro Cloud style guide](https://spectrocloud.atlassian.net/wiki/spaces/DE/pages/1765933057/Spectro+Cloud+Internal+Style+Guide) and best practices.

## Usage

Use the following steps to use the Spectro Cloud Vale package in your documentation.

1. Install Vale locally. You have multiple options to install Vale. For example, you can use Homebrew, Scoop, or Chocolatey. For more information, see the [Vale installation guide](https://vale.sh/docs/vale-cli/installation/).

   ```shell
   brew install vale
   ```

2. In the repository where you want to use the Spectro Cloud Vale package, create a `.vale.ini` file and add the following configuration:

   ```yaml
   StylesPath = vale/styles

   MinAlertLevel = suggestion

   Packages = https://github.com/spectrocloud/spectro-vale-pkg/releases/latest/download/spectrocloud.zip
   Vocab = spectrocloud-vocab

   [*.md]
   BasedOnStyles =  Vale, spectrocloud
   ```

3. In the repository `.gitignore` file, add the following line to ignore the Vale package files from being committed to the repository:

   ```shell
   .vale-config/
   vale/styles/spectrocloud/
   vale/styles/config/vocabularies/spectrocloud-vocab
   ```

4. Initialize the Vale package in the repository:

   ```shell
   vale sync
   ```

5. In the `.github/workflows` directory, create a new file titled `vale.yaml` and add the following configuration:

   ```yaml
   name: Vale

   on:
     pull_request:
       types: [opened, synchronize, reopened, ready_for_review]

   concurrency:
     group: vale-${{ github.ref }}
     cancel-in-progress: true

   jobs:
     run-ci:
       runs-on: ubuntu-latest
       defaults:
         run:
           shell: bash
       if: ${{ !github.event.pull_request.draft && github.actor != 'dependabot[bot]' && github.actor != 'dependabot-preview[bot]' }}
       steps:
         - run: exit 0

     vale:
       needs: [run-ci]
       uses: spectrocloud/spectro-vale-pkg/.github/workflows/vale.yml@main
   ```

You are now ready to use the Spectro Cloud Vale package in your documentation. The Vale package will be used on every pull request in the repository and provide feedback on new or modified markdown files.

> [!TIP]
> Pull Requests in draft mode will not trigger the writting checks. Make sure to mark the PR as ready for review to trigger the checks.

If a pull request does not meet the standards, Vale will provide suggestions on how to improve the documentation.

If you want to use Vale locally, issue the following command.

```shell
vale path/to/your/file
```

A detailed output will display the suggestions and errors in the documentation.

### Override Vale Version

You can override the Vale version used in the GitHub Action workflow by specifying the version in the YAML template. Below is an example you can use as a reference.

```shell
vale:
  needs: [run-ci]
  uses: spectrocloud/spectro-vale-pkg/.github/workflows/vale.yml@main
  with:
    version: '3.9.1'
```


## Contribution

For more information on contributing to this repository, please refer to the [Contribution Guide](docs/CONTRIBUTION.md).
