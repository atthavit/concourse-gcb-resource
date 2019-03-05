# Google Cloud Build Resource

Submits builds to Google Cloud Build


## Source Configuration

* `project`: *Required.* The name of the GCP  project.

* `json_key`: The content of GCP key file in json format.


## Behavior

### `check`: Do nothing.

### `in`: Do nothing.

### `push`: Submits a build to Google Cloud Build

#### Parameters

* `build`: *Required.* The path of a directory to build.

* `cloudbuild_path`: *Optional.* The path of `cloudbuild.yaml`

* `cloudbuild_content`: *Optional.* The content of `cloudbuild.yaml`

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
