# Devcontainer skeleton with Stata and R setup

This is set up for standard Codespaces **command line** operation, and optimized for AEA data editorial activities.

## Typical usage

A typical usage of this codespace (but currently not standard practice at the Office of the AEA Data Editor) looks like this:

- Initialize a manuscript specific Bitbucket repository ([instructions](https://labordynamicsinstitute.github.io/replicability-training-curriculum/aea-jira-workflow-a-guide.html#details)) using the [replication-template](https://github.com/AEADataEditor/replication-template).
- [Initiate a codespace from this repository](https://github.com/codespaces/new?hide_repo_select=true&amp;ref=main&amp;repo=473197646)
- From command-line,
  - clone the Bitbucket repository: `aeagit NNNN`
  - obtain the replication package: `python3 tools/download_openicpsr_private.py MMMMM`
  - assess the package, write preliminary report
  - make any necessary changes to the code (hopefully none)
  - run the code: `stata-mp -b do main.do`
  - assess the output
  - finalize report
  
Unfortunately, it is rarely that easy...

## Provided software

- Github CLI
- R (see Dockerfile for version)
- Rstudio (not started by default)
- Stata (see Dockerfile for version)

## Starting this Codespace environment

To start this in Codespaces, go to your personal [Codespaces](https://github.com/codespaces) space, and search for this repository to [start a codespace](https://docs.github.com/en/codespaces/developing-in-codespaces/opening-an-existing-codespace), or, alternatively, fork this repository into your Github organization and launch Codespaces from the green button menu.

It will use any environment variables that you have assigned to this repository. See [Github documentation on encrypted secrets](https://docs.github.com/en/codespaces/managing-your-codespaces/managing-encrypted-secrets-for-your-codespaces) to learn how to add specific secrets. You can add them to [your personal settings](https://github.com/settings/codespaces) or to the organization hosting the Codespace (e.g., [AEA secrets](https://github.com/organizations/AEADataEditor/settings/secrets/codespaces) or [LDI secrets](https://github.com/organizations/labordynamicsinstitute/settings/secrets/codespaces)).

### Useful environment variables (secrets)

These can be in personal space or organizational space.

- `P_FREDKEY` API key to use the [FRED API](https://fred.stlouisfed.org/docs/api/fred/) within Stata. See [this example](https://github.com/labordynamicsinstitute/alfred_example).
- `STATA_LIC_BASE64` - base64 encoded version of the Stata license file, see [this discussion](https://github.com/AEADataEditor/stata-project-with-docker). It can be generated with this single command line: `gh secret set STATA_LIC_BASE64 -b"$(cat stata.lic | base64)" -v all -o YOURORG` from within Codespaces after a one-time upload of the `stata.lic` file. You can use the Stata license installed on your own PC or Mac.

### AEA-specific variables

#### Personal space

You need to set these in  [your personal settings](https://github.com/settings/codespaces) to effectively use this environment. Naming should indicate their purpose pretty well.

- `P_BITBUCKET_USERNAME`
- `P_BITBUCKET_PAT`
- `P_DOCKERHUB_LOGIN`
- `P_DOCKERHUB_PAT`

#### Organization space

- `ICPSR_EMAIL`
- `ICPSR_PASS` - ICPSR credentials for downloading from the unpublished replication packages. Note that ICPSR does not provide an API, so this is actually the password (not great security practice)

## Rstudio

To enable Rstudio as the primary interface, see [notes in the Dockerfile](https://github.com/labordynamicsinstitute/codespaces-stata-r-skeleton/blob/361b1b19808800caeee598c7a67e78fecfb3a45e/.devcontainer/Dockerfile#L95), edit within Codespaces, and rebuild.

