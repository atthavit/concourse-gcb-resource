# Google Cloud Build Resource

A Concourse resource for submitting builds to Google Cloud Build


## Source Configuration

* `project`: *Required.* The name of the GCP  project.

* `json_key`: *Optional.* The content of GCP key file in json format.

* `cloudbuild_path`: *Optional.* The path of `cloudbuild.yaml`

* `cloudbuild_content`: *Optional.* The content of `cloudbuild.yaml`

* `substitutions`: *Optional.*

  Example:

  ```yaml
  substitutions:
    _ABC: 123
    _DEF: 456
  ```


## Behavior

### `check`: Do nothing.

### `in`: Do nothing.

### `push`: Submits a build to Google Cloud Build

#### Parameters

* `build`: *Required.* The path of a directory to build.

* `cloudbuild_path`: *Optional.* The path of `cloudbuild.yaml`. This has higher precedence than source configuration.

* `cloudbuild_content`: *Optional.* The content of `cloudbuild.yaml`. This has higher precedence than source configuration.

  Example:

  ```yaml
  steps:
  - name: 'alpine'
    args:
      - echo
      - abc
  ```

* `flags_file`: *Optional.* The path of flags file. (see <https://cloud.google.com/sdk/gcloud/reference/topic/flags-file>)

* `flags_file_content`: *Optional.* The content of flags file.

  Example:

  ```yaml
  flags_file_content: |
    --machine-type: n1-highcpu-8
  ```

* `substitutions`: *Optional.* This has will be merged with `source.substitutions`
