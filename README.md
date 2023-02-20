# README for  `msa_envs` 

Github repository for the [podman](https://podman.io/) conatiner [`msa_envs`](https://hub.docker.com/repository/docker/khench/msa_envs).
This is meant as a support of the [msa_pipeline](https://bitbucket.org/bucklerlab/msa_pipeline/src/master/) by the Buckler lab and likely somewhat redundant with their [original container](https://hub.docker.com/r/apscheben/msa_pipeline) (`apscheben/msa_pipeline`).

The main motivation for this container was to include all conda environments needed for the pipeline, where all environments listed in the directory `workflow/envs` with the naming convention `'envs/{name}.yaml'` -> `msa_{name}`, such that for example the conda environment specyfied within the file `envs/align.yaml` can be activated with `conda activate msa_align`.
This was done so that the execution of the `msa_pipeline` can be seamlessly toggled between the usage of `--use-conda` and `--use-singularity` (as long as the container and environment names in the `Snakefile` in the `rules/*.smk` files are adjusted accordingly):

eg replace the original (`workflow/rules/align.smk`),
line 8:

```
containerized: "docker://apscheben/msa_pipeline:latest"
```

with

```
containerized: "docker://khench/msa_envs:v0.1"
```

and eg lines 80-81:

```
    conda:
      '../envs/align.yaml'
```

with

```
    conda:
      'msa_align'
```

(and all  other instances of `conda` environments accordingly).

## Documentation of the initial setup

Originally, the `msa_envs` container was build using [buildah](https://buildah.io/), from the accompanying `Containerfile`:

```sh
buildah bud -t msa_envs
```

To make the container publicly available, it is pushed to [dockerhub](https://hub.docker.com/r/khench/msa_envs) using [skopeo](https://github.com/containers/skopeo) and [podman](https://podman.io/):

```sh
skopeo login -u khench docker.io
podman push localhost/msa_envs docker.io/khench/msa_envs:v0.1.1
```

## Accessing the container

The bundled software can be accessed directly from [dockerhub](https://hub.docker.com/r/khench/msa_envs) with `podman` (or `docker`, or `singularity`):

```sh
podman shell docker.io/khench/msa_envs:v0.1
```