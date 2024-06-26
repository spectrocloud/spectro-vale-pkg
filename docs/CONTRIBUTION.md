# Contribution

Contributions are welcome! Here are some ways you can contribute:

- by reporting bugs
- by suggesting new features
- by authoring a new Vale rule

If you want to contribute, please discuss this with the Docs & Education team first. This way, we can ensure that your contribution aligns with the project's goals and that you don't end up doing work that might not be accepted. Nobody wants to work on something that won't be used.

## Author a New Vale Rule

To create a new Vale rule, make sure you have the following software installed.

### Prerequisites

- [Vale](https://vale.sh/docs/vale-cli/installation/) v3.6.0 or later
- [Node.js](https://nodejs.org/en/download/prebuilt-installer) v20.0.0 or later
- You have discussed the rule with the Docs & Education team and have received approval.
- Cloned the repository and have the latest `main` branch version.

### Instructions

Use the following steps to create a new Vale rule.

1. Issue the command, `npm ci` to install the required dependencies.

2. Identify the package to which the rule should be added. Most rules are added to the `spectrocloud` package, as that is a public-facing package.

3. Create a YAML file in the `packages/spectrocloud/styles/spectrocloud` directory. Name the file according to the rule you are creating. For example, if you create a rule to check for ableism, name the file `ableism.yml`. Try to keep the rule name simple.

   > [!WARNING]
   > Make sure the file ends with `.yml` and not `yaml`. Otherwise, Vale will not recognize the file as a style file.

4. Follow the [Vale documentation](https://vale.sh/docs/topics/styles/) to create the rule.

5. We recommend you test the rule using [Vale Studio](https://studio.vale.sh/) along with a sample markdown file. This is an excellent way to ensure the rule works as expected while receiving immediate feedback.

6. Once satisfied with the rule, create a new folder in the `packages/spectrocloud/test/` folder. For example, if you create a rule to check for ableism, create a folder named `ableism`.

7. Inside the folder, create the following three files:

   - `pass.md`: A markdown file that passes the rule.
   - `fail.md`: A markdown file that fails the rule.
   - `.vale.init`: A configuration file that specifies the rule to be tested.

   The `.vale.init` file should contain the following content. Replace `[REPLACE_ME]` with the name of the rule you created.

   ```yaml
   StylesPath = ../../styles/
   MinAlertLevel = suggestion
   [*.md]
   spectrocloud.[REPLACE_ME] = YES
   ```

   > [!NOTE]
   > The `.vale.init` file explicitly specifies the rule to be tested. This is necessary because Vale does not automatically detect the rule.

8. Add sample markdown text to the `pass.md` and `fail.md` files. Make sure the `fail.md` file contains content that violates the rule you created. Remember, the test is only as good as the quality of the sample markdown. Try to include multiple scenarios to feel confident the rule behaves as expected.

   > [!TIP]
   > Try to use codeblocks and indented text. These are common areas where rules are applied and often missed during development.

9. You can test your rule by using the following options.

   - Issue the command `make tests`. This will start the test suite and test all the rules of all packages.

   - Navigate to the test folder where you have the three files and issue the command `vale --config=.vale.ini pass.md` or `vale --config=.vale.ini fail.md`. This will test the rule against the markdown files.

10. Once satisfied with the rule, create a Pull Request (PR) and submit it for review. Once the PR is ready for review, the automatic test suite will start and verify all required files are present and that the rule works as expected.
